extends Node2D

const Cube = preload("res://scenes/Cube.tscn")
const Union = preload("res://scenes/Union.tscn")

onready var union = Union.instance()
onready var cam = $Camera2D

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
		if !Globals.is_playing and game_can_start():
			Globals.is_playing = true
			get_node("/root/Main/DropZone").visible = false
			get_node("/root/Main/PlayBtn").visible = false
			start_game()

func start_game():
	var cubes = get_tree().get_nodes_in_group("Cubes")
	var lowest = cubes[0]
	
	# makes things go BOOOM!
	for cube in cubes:
		cube.mode = RigidBody2D.MODE_RIGID
	
	update_camera_follow()

func game_can_start() -> bool:
	var cubes = get_tree().get_nodes_in_group("Cubes")
	if Globals.n_cubes != len(cubes):
		return false
	return true

func update_camera_follow():
	var node = get_lowest_node()
	
	cam.get_parent().remove_child(cam)
	node.add_child(cam)
	
func get_lowest_node() ->Node2D:
	var nodes = get_tree().get_nodes_in_group("Cubes")
	var lowest = nodes[0]
	
	for node in nodes:
		lowest = node if node.position.y < lowest.position.y else lowest
		
	return lowest
