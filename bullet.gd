extends Area2D
class_name Bullet

var speed: float

func _process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Wall:
		queue_free()
