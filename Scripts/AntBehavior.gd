extends Node3D

const speed: float = 1.0
const angular_speed: float = PI
const TURN_EVERY = 0.5

var current_angle: float = 0
var expected_angle: float = 0

var next_turn: float = TURN_EVERY

func find_food() -> void:
	var available_food = get_tree().get_nodes_in_group("food")
	print(available_food[0])

func _ready() -> void:
	current_angle = randf_range(-PI, PI)
	find_food()

func _process(delta: float) -> void:
	next_turn -= delta
	if (next_turn < 0):
		expected_angle += randf_range(-PI / 2, PI / 2)
		next_turn += TURN_EVERY
	
	var remaining_angle = expected_angle - current_angle
	var angle_movement = sign(remaining_angle) * angular_speed * delta
	current_angle += angle_movement

	position += Vector3(1.0, 0, 0.0).rotated(Vector3.UP, current_angle) * delta * speed
