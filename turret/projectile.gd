class_name Projectile
extends Area3D


@export var speed := 30.0

var direction := Vector3.FORWARD


func _physics_process(delta: float) -> void:
	position += direction * delta * speed
