extends CharacterBody2D
class_name Player

@export var move_speed = 4000

@export var run_rotation = 30
@export var run_rotation_smoothing = 250
@export var gun_offset_smoothing = 20
@export var gun_scale_smoothing = 10

@export var gun: GunSettings

@onready var sprite := $Sprite
@onready var weapon_holder := $WeaponHolder
@onready var weapon := $WeaponHolder/Weapon
@onready var weapon_sprite := $WeaponHolder/Weapon/Sprite

var dust_scene = preload("res://dust.tscn")
var bullet_scene = preload("res://bullet.tscn")

var target_rotation = 0
var original_weapon_scale = Vector2.ONE
var next_time_to_fire = 0

func _ready() -> void:
	Globals.player = self
	weapon_sprite.texture = gun.sprite
	weapon.position.x = gun.offset

func _process(delta: float) -> void:
	sprite.rotation_degrees = move_toward(sprite.rotation_degrees, target_rotation,  run_rotation_smoothing * delta)

	weapon_holder.look_at(get_global_mouse_position())
	weapon_sprite.flip_v = not (weapon_holder.global_rotation_degrees > -90 and weapon_holder.global_rotation_degrees < 90)

	weapon.position.x = move_toward(weapon.position.x, gun.offset, gun_offset_smoothing * delta)
	weapon.scale = weapon.scale.move_toward(original_weapon_scale, gun_scale_smoothing * delta)

	if Input.is_action_pressed("fire") and Time.get_ticks_msec() >= next_time_to_fire:
		fire()

func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis("left", "right")
	var y_input = Input.get_axis("up", "down")

	velocity = Vector2(x_input, y_input) * move_speed * delta

	target_rotation = x_input * run_rotation

	move_and_slide()

func fire() -> void:
	next_time_to_fire = Time.get_ticks_msec() + 1000 / gun.fire_rate
	weapon.position.x = gun.offset - gun.kick
	weapon.scale = Vector2.ONE * gun.expand

	var bullet = bullet_scene.instantiate() as Bullet
	var spread = deg_to_rad(randf_range(-gun.spread, gun.spread))
	bullet.global_position = weapon.global_position
	bullet.scale = Vector2.ONE * gun.bullet_size
	bullet.look_at(get_global_mouse_position().rotated(spread))
	bullet.speed = gun.bullet_speed
	Globals.world.add_child(bullet)

func _on_dust_timer_timeout() -> void:
	var dust = dust_scene.instantiate() as Sprite2D
	dust.global_position = global_position
	add_child(dust)
