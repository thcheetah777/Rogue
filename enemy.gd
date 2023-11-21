extends CharacterBody2D
class_name Enemy

@export var max_health = 8
@export var scale_smoothing = 3
@export var hurt_expand = 1.6

@onready var sprite := $AnimatedSprite

var health = max_health
var original_scale = Vector2.ONE

func _ready() -> void:
	original_scale = scale

func _process(delta: float) -> void:
	scale = scale.move_toward(original_scale, scale_smoothing * delta)

func take_damage(amount: float):
	health -= amount
	scale = hurt_expand * Vector2.ONE
	sprite.play("hurt")
	if health <= 0:
		die()

func die():
	queue_free()
	Events.emit_signal("enemy_died")
