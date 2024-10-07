extends Node

var current_food: int = 0
var current_antlings: int = 0
var current_workers: int = 0
var current_matriarchs: int = 0

func _on_main_scene_food_changed(new_value: int) -> void:
	current_food = new_value
	$FoodLabel.text = "Food: " + str(new_value)
	update_buttons_state()

func _on_main_scene_ants_changed(antlings: int, workers: int, matriarchs: int) -> void:
	current_antlings = antlings
	current_workers = workers
	current_matriarchs = matriarchs
	$BuyAntlingButton.text = str(antlings) + " / 100 antlings\n(1 food)"
	$BuyWorkerAntButton.text = str(workers) + " / 50 workers\n(5 antlings, 10 food)"
	$BuyMatriarchButton.text = str(matriarchs) + " / 10 matriarchs\n(5 workers, 100 food)"
	update_buttons_state()

func update_buttons_state() -> void:
	$BuyAntlingButton.disabled = current_food < 1
	$BuyWorkerAntButton.disabled = current_antlings < 5 || current_food < 10
	$BuyMatriarchButton.disabled = current_workers < 5 || current_food < 100
