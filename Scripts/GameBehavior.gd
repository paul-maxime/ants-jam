extends Node

const MAP_SIZE = 80
const MAP_MAX = MAP_SIZE / 2
const MAP_MIN = -MAP_SIZE / 2 

var ant_scene = preload("res://Scenes/Entities/Ant.tscn")
var apple_scene = preload("res://Scenes/Entities/Apple.tscn")

var current_food: int = 0

signal food_changed(new_value: int)
signal ants_changed(antlings: int, workers: int, matriarchs: int)

func _ready() -> void:
	change_food(5)
	update_ants_count()
		
	for i in range(50):
		spawn_apple(8)
		spawn_apple(32)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F and Input.is_key_pressed(KEY_ALT):
			change_food(1000)

func spawn_apple(min_distance: float) -> void:
	var position
	var other_apples: Array[Node] = get_tree().get_nodes_in_group("food")
	for i in range(1000):
		position = Vector3(randf_range(MAP_MIN + 5, MAP_MAX - 5), 0, randf_range(MAP_MIN + 5, MAP_MAX - 5))
		if position.distance_to(Vector3(0, 0, 0)) < min_distance: continue
		if is_apple_near_position(position, other_apples): continue
		break
	
	var apple: Node3D = apple_scene.instantiate()
	apple.visible = false
	apple.position = position
	apple.rotation = randf_range(-PI, PI) * Vector3.UP
	add_child(apple)

func is_apple_near_position(position: Vector3, other_apples: Array[Node]):
	for other_apple in other_apples:
		if position.distance_to(other_apple.position) < 3:
			return true
	return false

func change_food(delta: int) -> void:
	current_food += delta
	food_changed.emit(current_food)

func update_ants_count() -> void:
	var all_ants: Array[Node] = get_tree().get_nodes_in_group("ant")
	var antlings = 0
	var workers = 0
	var matriarchs = 0
	for ant in all_ants:
		if ant.sacrificed: continue
		if ant.ant_type == 3:
			matriarchs += 1
		elif ant.ant_type == 2:
			workers += 1
		else:
			antlings += 1
	ants_changed.emit(antlings, workers, matriarchs)

func sacrifice_ants(type: int, count: int) -> bool:
	var remaining: int = count
	var all_ants: Array[Node] = get_tree().get_nodes_in_group("ant")
	all_ants.shuffle()
	for ant in all_ants:
		if ant.ant_type == type:
			ant.sacrificed = true
			ant.queue_free()
			remaining -= 1
			if remaining == 0: return true
	return false

func _on_buy_antling_button_pressed() -> void:
	if current_food < 1:
		return
	change_food(-1)
	add_child(ant_scene.instantiate())
	update_ants_count()

func _on_buy_worker_ant_button_pressed() -> void:
	if current_food < 10:
		return
	sacrifice_ants(1, 5)
	change_food(-10)
	var ant = ant_scene.instantiate()
	ant.upgrade(2, 2.0)
	add_child(ant)
	update_ants_count()

func _on_buy_matriarch_button_pressed() -> void:
	if current_food < 100:
		return
	change_food(-100)
	sacrifice_ants(2, 5)
	var ant = ant_scene.instantiate()
	ant.upgrade(3, 3.5)
	add_child(ant)
	update_ants_count()
