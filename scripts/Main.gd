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


func _on_PlayBtn_gui_input(event):
	if event.is_pressed():
		print(Globals.is_playing)
		if !Globals.is_playing:
			Globals.is_playing = true
			start_game()

func start_game():
	var cubes = get_tree().get_nodes_in_group("Cubes")
	
	# makes things go BOOOM!
	for cube in cubes:
		cube.mode = RigidBody2D.MODE_RIGID
