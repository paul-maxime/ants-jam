extends Node

var remaining_food = 100
var state = 3

func take_food(max: int) -> int:
	var taken: int = min(remaining_food, max)
	remaining_food -= taken
	if state == 3 and remaining_food < 80:
		state = 2
		$AppleFull.visible = false
		$AppleHalf.visible = true
	if state == 2 and remaining_food < 30:
		state = 1
		$AppleHalf.visible = false
		$AppleEaten.visible = true
	if remaining_food <= 0:
		queue_free()
	return taken
