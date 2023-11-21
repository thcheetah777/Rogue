extends CharacterBody2D
class_name Enemy

@export var max_health = 5
@export var scale_smoothing = 3
@export var hurt_expand = 1.6
@export var hurt_animation_time = 0.2

@onready var sprite := $Sprite

var health = max_health
var original_scale = Vector2.ONE
var hurt_animation_count = 0

func _ready() -> void:
	original_scale = scale

func _process(delta: float) -> void:
	scale = scale.move_toward(original_scale, scale_smoothing * delta)

	hurt_animation_count -= delta
	if hurt_animation_count <= 0:
		sprite.self_modulate = Globals.ENEMY_COLOR

func take_damage(amount: float):
	health -= amount
	scale = hurt_expand * Vector2.ONE
	sprite.self_modulate = Globals.BLANK_COLOR
	hurt_animation_count = hurt_animation_time
	if health <= 0:
		die()

func die():
	queue_free()
	Events.emit_signal("enemy_died")
