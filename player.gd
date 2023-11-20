extends CharacterBody2D
class_name Player

@export var move_speed = 4000

@export var run_rotation = 30
@export var run_rotation_smoothing = 250

@onready var sprite := $Sprite

var target_rotation = 0

func _ready() -> void:
	Globals.player = self

func _process(delta: float) -> void:
	sprite.rotation_degrees = move_toward(sprite.rotation_degrees, target_rotation,  run_rotation_smoothing * delta)

func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis("left", "right")
	var y_input = Input.get_axis("up", "down")

	velocity = Vector2(x_input, y_input) * move_speed * delta

	target_rotation = x_input * run_rotation

	move_and_slide()
