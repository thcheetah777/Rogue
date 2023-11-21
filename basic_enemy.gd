extends Enemy
class_name BasicEnemy

@export var move_speed = 20

func _physics_process(_delta: float) -> void:
	look_at(Globals.player.position)
	velocity = Vector2.RIGHT.rotated(rotation) * move_speed

	move_and_slide()
