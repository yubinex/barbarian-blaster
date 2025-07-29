class_name Projectile
extends Area3D


@export var speed := 30.0
@export var damage := 25

var direction := Vector3.FORWARD


func _physics_process(delta: float) -> void:
	position += direction * delta * speed


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy_area"):
		area.get_parent().current_health -= damage
		queue_free()
