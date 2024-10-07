extends Node3D

const SPEED: float = 1.0
const ANGULAR_SPEED: float = PI
const WALK_FOR_MIN = 2.0
const WALK_FOR_MAX = 4.0
const PAUSE_DURATION_MIN = 0.5
const PAUSE_DURATION_MAX = 2.5

var wandering_angle: float = 0
var next_thinking: float = 0
var pause_for: float = 0
var current_size: float = 1

var target_food: Node3D = null
var has_food: bool = false

func find_food() -> void:
	var available_food = get_tree().get_nodes_in_group("food")
	for food in available_food:
		if position.distance_to(food.position) < 5:
			target_food = food
			return

func _ready() -> void:
	var random_angle = randf_range(-PI, PI)
	rotation.y = random_angle
	wandering_angle = random_angle
	think(false)

func get_current_angle() -> float:
	return rotation.y

func _process(delta: float) -> void:
	if pause_for > 0:
		$AnimationPlayer.stop()
		$"Ant Armature/Skeleton3D".show_rest_only = true
		pause_for -= delta
		return

	$AnimationPlayer.play("Walking")
	$"Ant Armature/Skeleton3D".show_rest_only = false
	
	if not has_food:
		next_thinking -= delta
		if next_thinking < 0:
			think(true)
			return
	
	if not is_instance_valid(target_food):
		wander_randomly(delta)
	elif not has_food:
		gather_food(delta)
	else:
		return_to_anthill(delta)

func think(should_pause: bool) -> void:
	if not is_instance_valid(target_food):
		find_food()
	if not is_instance_valid(target_food):
		wandering_angle += randf_range(-PI / 2, PI / 2)
	reset_thinking(should_pause)

func wander_randomly(delta: float) -> void:
	if rotate_ant_towards(delta, wandering_angle):
		position += Vector3(0, 0, 1).rotated(Vector3.UP, get_current_angle()) * delta * SPEED
		if position.x > $/root/MainScene.MAP_MAX: position.x = $/root/MainScene.MAP_MAX
		if position.z > $/root/MainScene.MAP_MAX: position.z = $/root/MainScene.MAP_MAX
		if position.x < $/root/MainScene.MAP_MIN: position.x = $/root/MainScene.MAP_MIN
		if position.z < $/root/MainScene.MAP_MIN: position.z = $/root/MainScene.MAP_MIN

func gather_food(delta: float) -> void:
	if move_ant_towards(delta, target_food.position):
		has_food = true
		$AppleBite.visible = true
		reset_thinking(true)

func return_to_anthill(delta: float) -> void:
	if move_ant_towards(delta, Vector3.ZERO):
		has_food = false
		$AppleBite.visible = false
		reset_thinking(true)

func move_ant_towards(delta: float, target: Vector3) -> bool:
	var required_movement = target - position
	var expected_angle = Vector2(required_movement.z, required_movement.x).angle()
	if rotate_ant_towards(delta, expected_angle):
		position = position.move_toward(target, delta * SPEED)
		if position.distance_to(target) < 0.001:
			position = target
			return true
	return false

func rotate_ant_towards(delta, angle: float) -> bool:
	rotation.y = rotate_toward(rotation.y, angle, ANGULAR_SPEED * delta)
	if abs(angle_difference(rotation.y, angle)) < 0.001:
		rotation.y = angle
		return true
	return false

func reset_thinking(should_pause: bool) -> void:
	next_thinking = randf_range(WALK_FOR_MIN, WALK_FOR_MAX)
	if should_pause:
		pause_for = randf_range(PAUSE_DURATION_MIN, PAUSE_DURATION_MAX)
