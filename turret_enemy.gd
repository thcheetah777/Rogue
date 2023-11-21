extends Enemy

@export var rotate_speed = 2
@export var bullet_speed = 100
@export var damage = 10
@export var fire_delay_min = 2
@export var fire_delay_max = 4

@onready var timer := $FireTimer

var bullet_scene = preload("res://enemy_bullet.tscn")

func _ready() -> void:
	randomize_timer()
	timer.start()

func _physics_process(delta: float) -> void:
	var difference = (position - Globals.player.position).normalized()
	rotation = move_toward(rotation, difference.angle(), rotate_speed * delta)
	move_and_slide()

func randomize_timer():
	timer.wait_time = randf_range(fire_delay_min, fire_delay_max)

func _on_fire_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate() as EnemyBullet
	bullet.global_position = global_position
	bullet.speed = bullet_speed
	bullet.damage = damage
	bullet.rotation = rotation + PI
	Globals.world.add_child(bullet)

	randomize_timer()
