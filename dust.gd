extends Sprite2D

const DURATION = 1

func _ready() -> void:
	var tween = get_tree().create_tween().set_parallel()
	tween.tween_property(self, "rotation_degrees", 180 if randf() > 0.5 else -180, DURATION)
	tween.tween_property(self, "scale", Vector2.ZERO, DURATION)
	tween.tween_callback(queue_free).set_delay(DURATION)
