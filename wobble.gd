extends Node

@export var speed = 0.5
@export var magnitude = 25

func _ready() -> void:
	if not get_parent() is Node2D:
		queue_free()

func _process(delta: float) -> void:
	get_parent().rotation_degrees = sin(Time.get_ticks_msec() * speed * delta) * magnitude
