extends Camera3D


@export var raycast_distance: float = 100.0

@onready var ray_cast_3d: RayCast3D = $RayCast3D


func _process(_delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * raycast_distance
	ray_cast_3d.force_raycast_update()
	printt(ray_cast_3d.get_collider(), ray_cast_3d.get_collision_point())
