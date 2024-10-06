extends Camera3D

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				size -= 1
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				size += 1
	elif event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			position -= Vector3(event.relative.x, 0, event.relative.y).rotated(Vector3.UP, PI / 4) * size / 600.0
