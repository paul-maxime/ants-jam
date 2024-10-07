extends Camera3D

const HARD_LIMIT_MIN = -110
const HARD_LIMIT_MAX = 190
const ZOOM_LEVELS = [5, 6, 8, 10, 15, 25, 35, 45]

var current_zoom = 5

func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if current_zoom > 0:
					current_zoom -= 1
					size = ZOOM_LEVELS[current_zoom]
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if current_zoom < ZOOM_LEVELS.size() - 1:
					current_zoom += 1
					size = ZOOM_LEVELS[current_zoom]
	elif event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			print("Camera moved ", event.relative)
			position -= Vector3(event.relative.x, 0, event.relative.y).rotated(Vector3.UP, PI / 4) * size / 600.0
			enforce_limits()

func enforce_limits() -> void:
	if position.x < HARD_LIMIT_MIN: position.x = HARD_LIMIT_MIN
	if position.x > HARD_LIMIT_MAX: position.x = HARD_LIMIT_MAX
	if position.z < HARD_LIMIT_MIN: position.z = HARD_LIMIT_MIN
	if position.z > HARD_LIMIT_MAX: position.z = HARD_LIMIT_MAX
