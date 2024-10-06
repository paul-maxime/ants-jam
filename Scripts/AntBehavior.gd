extends Node3D

const SPEED: float = 1.0
const ANGULAR_SPEED: float = PI
const WALK_FOR_MIN = 2.0
const WALK_FOR_MAX = 4.0
const PAUSE_DURATION_MIN = 0.5
const PAUSE_DURATION_MAX = 2.5

var current_angle: float = 0
var expected_angle: float = 0
var next_turn: float = 0
var pause_for: float = 0

func find_food() -> void:
	var available_food = get_tree().get_nodes_in_group("food")

func _ready() -> void:
	current_angle = randf_range(-PI, PI)
	expected_angle = current_angle
	next_turn = randf_range(WALK_FOR_MIN, WALK_FOR_MAX)
	
	var random_scale = randf_range(1, 2)
	scale *= Vector3(random_scale, random_scale, random_scale)

	find_food()

func _process(delta: float) -> void:
	if pause_for > 0:
		pause_for -= delta
		return
	
	next_turn -= delta
	if next_turn < 0:
		pause_for = randf_range(PAUSE_DURATION_MIN, PAUSE_DURATION_MAX)
		expected_angle += randf_range(-PI / 2, PI / 2)
		next_turn += randf_range(WALK_FOR_MIN, WALK_FOR_MAX)
	
	var remaining_angle = expected_angle - current_angle
	var angle_movement = sign(remaining_angle) * ANGULAR_SPEED * delta
	if (abs(remaining_angle) > abs(angle_movement)):
		current_angle += angle_movement
	else:
		current_angle = expected_angle
		position += Vector3(1.0, 0, 0.0).rotated(Vector3.UP, current_angle) * delta * SPEED
	rotation = Vector3(0, current_angle + PI / 2, 0)
