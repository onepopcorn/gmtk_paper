extends Node2D

const Cube = preload("res://scenes/Cube.tscn")

var cubes = [
	'e82222',
	'261bed',
	'29b719',
	'b719d3'
]

func _ready():
	var last_pos = Vector2(48 * 6, 48)
	for color in cubes:
		var cube = Cube.instance()
		cube.color = color
		cube.position = last_pos
		add_child(cube)

		last_pos.x += cube.tile_size
