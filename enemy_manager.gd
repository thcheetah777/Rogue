extends Node

@export var wave_formations: Array[WaveFormation]

var level = 0
var exclamation_scene = preload("res://exclamation.tscn")
var current_formation = null
var enemy_count = 0

var basic_enemy_scene = preload("res://basic_enemy.tscn")

@onready var spawn_delay_timer := $SpawnDelayTimer

func _ready() -> void:
	Events.enemy_died.connect(_on_enemy_died)
	new_wave()

func create_exclamations():
	current_formation = wave_formations.pick_random() as WaveFormation
	enemy_count = current_formation.enemies.size()
	for enemy in current_formation.enemies:
		var exclamation = exclamation_scene.instantiate() as Exclamation
		exclamation.autodestruct_delay = spawn_delay_timer.wait_time
		exclamation.position = enemy.position
		Globals.world.add_child(exclamation)

func new_wave():
	create_exclamations()
	spawn_delay_timer.start()

func _on_spawn_delay_timeout() -> void:
	for enemy in current_formation.enemies:
		var new_enemy = basic_enemy_scene.instantiate()
		new_enemy.position = enemy.position
		Globals.world.add_child(new_enemy)

func _on_enemy_died():
	enemy_count -= 1
	if enemy_count <= 0:
		new_wave()
