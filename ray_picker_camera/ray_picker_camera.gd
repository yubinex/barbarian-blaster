extends Camera3D


@export var raycast_distance: float = 100.0
@export var grid_map: GridMap
@export var turret_manager: Turret

@onready var ray_cast_3d: RayCast3D = $RayCast3D


enum TileType {
	FREE_SPACE = 0,
	TURRET_SPACE = 1,
}


func _process(_delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * raycast_distance
	ray_cast_3d.force_raycast_update()

	if ray_cast_3d.is_colliding():
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		var collider = ray_cast_3d.get_collider()

		if collider is GridMap:
			if Input.is_action_just_pressed("click"):
				var collision_point: Vector3 = ray_cast_3d.get_collision_point()
				var cell_coordinates: Vector3i = grid_map.local_to_map(collision_point)

				if grid_map.get_cell_item(cell_coordinates) == TileType.FREE_SPACE:
					grid_map.set_cell_item(cell_coordinates, TileType.TURRET_SPACE)
					var tile_position: Vector3 = grid_map.map_to_local(cell_coordinates)
					turret_manager.build_turret(tile_position)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
