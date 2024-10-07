extends Node

var ant_scene = preload("res://Scenes/Entities/Ant.tscn")
var apple_scene = preload("res://Scenes/Entities/Apple.tscn")

func _ready() -> void:
	print("Spawning ants...")
	for i in range(100):
		add_child(ant_scene.instantiate())
	print("Spawning apples...")
	for i in range(80):
		spawn_apple()

func spawn_apple() -> void:
	var position
	var other_apples: Array[Node] = get_tree().get_nodes_in_group("food")
	for i in range(1000):
		position = Vector3(randf_range(-50, 50), 0, randf_range(-50, 50))
		if position.distance_to(Vector3(0, 0, 0)) < 10: continue
		if is_apple_near_position(position, other_apples): continue
		break
	
	var apple: Node3D = apple_scene.instantiate()
	apple.position = position
	add_child(apple)

func is_apple_near_position(position: Vector3, other_apples: Array[Node]):
	for other_apple in other_apples:
		if position.distance_to(other_apple.position) < 5:
			return true
	return false

func _process(_delta: float) -> void:
	$FpsCounterLabel.text = "FPS: " + str(Engine.get_frames_per_second())
