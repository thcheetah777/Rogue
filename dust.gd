extends Timer

@export var dust_color = Color("1d354a")

var dust_scene = preload("res://dust_particle.tscn")

func _on_timeout() -> void:
	var dust = dust_scene.instantiate() as Sprite2D
	dust.global_position = get_parent().position
	dust.self_modulate = dust_color
	add_child(dust)
