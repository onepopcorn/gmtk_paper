extends Node2D

const Cube = preload("res://scenes/Cube.tscn")
const Union = preload("res://scenes/Union.tscn")

var cubes = [
	'e82222',
	'261bed',
	'29b719',
	'b719d3'
]

onready var union = Union.instance()

func _ready():
	var last_pos = Vector2(48 * 6, 48)
	for color in cubes:
		var cube = Cube.instance()
		cube.color = color
		cube.position = last_pos
		cube.connect("joinCubesStart", self, "onJoinCubesStart")
		cube.connect("joinCubesStop", self, "onJoinCubesStop")
		add_child(cube)

		last_pos.x += cube.tile_size


func onJoinCubesStart(cube):
	print("start")
	union.add_point(cube.position)

func onJoinCubesStop(cube):
	print("stop")
	union.add_point(cube.position)
	add_child(union)
	print(union.get_point_count())
	union.z_index = 100000
	union.show()
	union = Union.instance()
