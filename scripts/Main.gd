extends Node2D

const Cube = preload("res://scenes/Cube.tscn")
const Union = preload("res://scenes/Union.tscn")

onready var union = Union.instance()

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
