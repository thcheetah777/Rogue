extends Enemy
class_name BasicEnemy

@export var dash_speed_min = 30
@export var dash_speed_max = 60
@export var decceleration = 30

func _ready() -> void:
	dash()

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, decceleration * delta)

	if not velocity:
		dash()

	move_and_slide()

func dash():
	look_at(Globals.player.position)
	var speed = randf_range(dash_speed_min, dash_speed_max)
	velocity = Vector2.RIGHT.rotated(rotation) * speed
