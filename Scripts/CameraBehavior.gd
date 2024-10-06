extends Camera3D

const MIN_SIZE = 2
const MAX_SIZE = 50

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if size > MIN_SIZE:
					size -= 1
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if size < MAX_SIZE:
					size += 1
	elif event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			position -= Vector3(event.relative.x, 0, event.relative.y).rotated(Vector3.UP, PI / 4) * size / 600.0
			if position.x < 0: position.x = 0
			if position.x > 100: position.x = 100
			if position.z < 0: position.z = 0
			if position.z > 100: position.z = 100
