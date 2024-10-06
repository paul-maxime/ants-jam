extends Node3D

const speed: float = 1.0
const angular_speed: float = PI / 2

const TURN_EVERY_MIN = 0.8
const TURN_EVERY_MAX = 1.2

var current_angle: float = 0
var expected_angle: float = 0
var next_turn: float = 0

func find_food() -> void:
	var available_food = get_tree().get_nodes_in_group("food")

func _ready() -> void:
	current_angle = randf_range(-PI, PI)
	expected_angle = current_angle
	next_turn = randf_range(TURN_EVERY_MIN, TURN_EVERY_MAX)
	find_food()

func _process(delta: float) -> void:
	next_turn -= delta
	if (next_turn < 0):
		expected_angle += randf_range(-PI / 2, PI / 2)
		next_turn += randf_range(TURN_EVERY_MIN, TURN_EVERY_MAX)
	
	var remaining_angle = expected_angle - current_angle
	var angle_movement = sign(remaining_angle) * angular_speed * delta
	current_angle += angle_movement
	
	rotation = Vector3(0, current_angle + PI / 2, 0)
	position += Vector3(1.0, 0, 0.0).rotated(Vector3.UP, current_angle) * delta * speed
