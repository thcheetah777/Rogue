extends CharacterBody2D
class_name Enemy

@export var max_health = 8

var health = max_health

func take_damage(amount: float):
	health -= amount
	if health <= 0:
		queue_free()
