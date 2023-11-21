extends Sprite2D

const DURATION = 1

var tween

func _ready() -> void:
	get_parent().remove_child(self)
	Globals.world.add_child(self)
	tween = get_tree().create_tween().set_parallel()
	tween.tween_property(self, "rotation_degrees", 180 if randf() > 0.5 else -180, DURATION)
	tween.tween_property(self, "scale", Vector2.ZERO, DURATION)
	tween.tween_callback(queue_free).set_delay(DURATION)
