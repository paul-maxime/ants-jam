extends Node

var floor_part_scene = preload("res://Scenes/Entities/FloorPart.tscn")
var next_update: float = 1.0

var all_floor_parts: Array[Node3D] = []

func _ready() -> void:
	for x: int in range(-39, 39 + 1, 2):
		for z: int in range(-39, 39 + 1, 2):
			var floor_part = floor_part_scene.instantiate() as Node3D
			floor_part.position = Vector3(x, 0, z)
			floor_part.visible = x >= -3 && x <= 3 && z >= -3 && z <= 3
			all_floor_parts.append(floor_part)
			add_child(floor_part)

func _process(delta: float) -> void:
	next_update -= delta
	if next_update < 0:
		next_update = randf_range(1.0, 1.5)
		update_fog()

func update_fog() -> void:
	var all_ants: Array[Node] = get_tree().get_nodes_in_group("ant")
	var all_food: Array[Node] = get_tree().get_nodes_in_group("food")
	for ant: Node3D in all_ants:
		for food in all_food:
			if ant.position.distance_to(food.position) < 3:
				food.visible = true
		for floor_part in all_floor_parts:
			if ant.position.distance_to(floor_part.position) < 3:
				floor_part.visible = true
