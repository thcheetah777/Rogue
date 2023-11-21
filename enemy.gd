extends CharacterBody2D
class_name Enemy

@export var max_health = 5

var health = max_health

func take_damage(amount: float):
	health -= amount
