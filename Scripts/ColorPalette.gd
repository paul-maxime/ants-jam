extends Node

const SOGGY_NEWSPAPERS_BLACK = Color("0d0e0a")
const SOGGY_NEWSPAPERS_GRAY = Color("5c5b5b")
const SOGGY_NEWSPAPERS_LIGHT_GRAY = Color("8f8e8a")
const SOGGY_NEWSPAPERS_WHITE = Color("dbe6e9")

var ant_body = preload("res://Materials/AntBodyMaterial.tres")
var ant_eyes = preload("res://Materials/AntEyesMaterial.tres")
var anthill_base = preload("res://Materials/AnthillBase.tres")
var anthill_hole = preload("res://Materials/AnthillHole.tres")
var anthill_middle = preload("res://Materials/AnthillMiddle.tres")
var anthill_stone1 = preload("res://Materials/AnthillStone1.tres")
var anthill_stone2 = preload("res://Materials/AnthillStone2.tres")
var anthill_top = preload("res://Materials/AnthillTop.tres")
var apple_flesh = preload("res://Materials/AppleFleshMaterial.tres")
var apple_leaf = preload("res://Materials/AppleLeafMaterial.tres")
var apple_seed = preload("res://Materials/AppleSeedMaterial.tres")
var apple_skin = preload("res://Materials/AppleSkinMaterial.tres")
var apple_stem = preload("res://Materials/AppleStemMaterial.tres")
var floor = preload("res://Materials/FloorMaterial.tres")

var default_ant_body = ant_body.albedo_color
var default_ant_eyes = ant_eyes.albedo_color
var default_anthill_base = anthill_base.albedo_color
var default_anthill_hole = anthill_hole.albedo_color
var default_anthill_middle = anthill_middle.albedo_color
var default_anthill_stone1 = anthill_stone1.albedo_color
var default_anthill_stone2 = anthill_stone2.albedo_color
var default_anthill_top = anthill_top.albedo_color
var default_apple_flesh = apple_flesh.albedo_color
var default_apple_leaf = apple_leaf.albedo_color
var default_apple_seed = apple_seed.albedo_color
var default_apple_skin = apple_skin.albedo_color
var default_apple_stem = apple_stem.albedo_color
var default_floor = floor.albedo_color

var is_black_and_white = false

func _ready() -> void:
	apply_black_white_palette()
	$SwapPaletteButton.connect("pressed", swap_palette)

func swap_palette() -> void:
	if not is_black_and_white:
		apply_black_white_palette()
	else:
		revert_color_palette()

func apply_black_white_palette() -> void:
	is_black_and_white = true
	ant_body.albedo_color = SOGGY_NEWSPAPERS_BLACK
	ant_eyes.albedo_color = SOGGY_NEWSPAPERS_LIGHT_GRAY
	anthill_base.albedo_color = SOGGY_NEWSPAPERS_BLACK
	anthill_hole.albedo_color = SOGGY_NEWSPAPERS_BLACK
	anthill_middle.albedo_color = SOGGY_NEWSPAPERS_GRAY
	anthill_stone1.albedo_color = SOGGY_NEWSPAPERS_LIGHT_GRAY
	anthill_stone2.albedo_color = SOGGY_NEWSPAPERS_GRAY
	anthill_top.albedo_color = SOGGY_NEWSPAPERS_LIGHT_GRAY
	apple_flesh.albedo_color = SOGGY_NEWSPAPERS_WHITE
	apple_leaf.albedo_color = SOGGY_NEWSPAPERS_LIGHT_GRAY
	apple_seed.albedo_color = SOGGY_NEWSPAPERS_BLACK
	apple_skin.albedo_color = SOGGY_NEWSPAPERS_GRAY
	apple_stem.albedo_color = SOGGY_NEWSPAPERS_BLACK
	floor.albedo_color = SOGGY_NEWSPAPERS_LIGHT_GRAY

func revert_color_palette() -> void:
	is_black_and_white = false
	ant_body.albedo_color = default_ant_body
	ant_eyes.albedo_color = default_ant_eyes
	anthill_base.albedo_color = default_anthill_base
	anthill_hole.albedo_color = default_anthill_hole
	anthill_middle.albedo_color = default_anthill_middle
	anthill_stone1.albedo_color = default_anthill_stone1
	anthill_stone2.albedo_color = default_anthill_stone2
	anthill_top.albedo_color = default_anthill_top
	apple_flesh.albedo_color = default_apple_flesh
	apple_leaf.albedo_color = default_apple_leaf
	apple_seed.albedo_color = default_apple_seed
	apple_skin.albedo_color = default_apple_skin
	apple_stem.albedo_color = default_apple_stem
	floor.albedo_color = default_floor
