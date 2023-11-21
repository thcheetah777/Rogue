extends Area2D
class_name Bullet

var speed: float
var damage: float

func _process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Wall:
		queue_free()

	if body is Enemy:
		var enemy = body as Enemy
		enemy.take_damage(damage)
		queue_free()
