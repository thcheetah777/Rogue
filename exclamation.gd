extends Sprite2D
class_name Exclamation

var autodestruct_delay = 0

@onready var timer := $AutodestructTimer

func _ready() -> void:
	timer.wait_time = autodestruct_delay
	timer.start()

func _on_autodestruct_timer_timeout() -> void:
	queue_free()
