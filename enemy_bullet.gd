extends Area2D
class_name EnemyBullet

var speed: float
var damage: float

func _process(delta: float) -> void:
	global_position += Vector2.from_angle(rotation) * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Wall:
		queue_free()
