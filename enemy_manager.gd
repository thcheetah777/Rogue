extends Node

@export var wave_formations: Array[WaveFormation] = []

var level = 0
var exclamation_scene = preload("res://exclamation.tscn")
var current_formation = null

var basic_enemy_scene = preload("res://basic_enemy.tscn")

@onready var spawn_delay_timer := $SpawnDelayTimer

func _ready() -> void:
	create_exclamations()

func create_exclamations():
	current_formation = wave_formations.pick_random() as WaveFormation
	for enemy in current_formation.enemies:
		var exclamation = exclamation_scene.instantiate() as Exclamation
		exclamation.autodestruct_delay = spawn_delay_timer.wait_time
		exclamation.position = enemy.position
		Globals.world.add_child(exclamation)

func _on_spawn_delay_timeout() -> void:
	for enemy in current_formation.enemies:
		var new_enemy = basic_enemy_scene.instantiate()
		new_enemy.position = enemy.position
		Globals.world.add_child(new_enemy)
