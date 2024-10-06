extends Node

var ant_scene = preload("res://Scenes/Entities/Ant.tscn")

func _ready() -> void:
	for i in range(2000):
		add_child(ant_scene.instantiate())
