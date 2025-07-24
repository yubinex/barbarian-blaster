class_name Turret
extends Node3D


@export var projectile: PackedScene
@export var turret_range := 10.0

var enemy_path: Path3D
var target: PathFollow3D

@onready var turret_top: MeshInstance3D = $TurretBase/TurretTop
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(_delta: float) -> void:
	target = find_best_target()
	if target: look_at(target.global_position, Vector3.UP, true)


func _on_timer_timeout() -> void:
	if not target: return

	var shot: Projectile = projectile.instantiate()
	add_child(shot)
	shot.global_position = turret_top.global_position
	shot.direction = global_transform.basis.z

	animation_player.play("fire")


func find_best_target() -> PathFollow3D:
	var best_target = null
	var furthest_progress := 0
	for enemy in enemy_path.get_children():
		if enemy is not PathFollow3D:
			continue

		var distance := global_position.distance_to(enemy.global_position)
		if distance > turret_range:
			continue

		if enemy.progress > furthest_progress:
			best_target = enemy
			furthest_progress = enemy.progress
	return best_target
