extends Node


@export var game_length := 30.0
@export var spawn_time_curve: Curve

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.start(game_length)


func _process(_delta: float) -> void:
	print(get_spawn_time())


func game_progress_ratio() -> float:
	return 1.0 - (timer.time_left / game_length)


func get_spawn_time() -> float:
	return spawn_time_curve.sample(game_progress_ratio())
