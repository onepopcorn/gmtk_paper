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
			
func _on_cube_destroyed(node):
	if cam.get_parent() == node:
		node.remove_from_group('Cubes')
		node.queue_free()
		update_camera_follow()
		
func _on_cube_frozen(node):
	node.remove_from_group('Cubes')
	update_camera_follow()

func start_game():
	var cubes = get_tree().get_nodes_in_group("Cubes")
	var lowest = cubes[0]
	
	# makes things go BOOOM!
	for cube in cubes:
		cube.mode = RigidBody2D.MODE_RIGID
		cube.connect("cube_destroyed", self, "_on_cube_destroyed")
		cube.connect("cube_frozen", self, "_on_cube_frozen")
		
		# Give some physics properties to the falling pieces
		cube.set_friction(.3)
		cube.set_bounce(.3)
	
	update_camera_follow()

func game_can_start() -> bool:
	var cubes = get_tree().get_nodes_in_group("Cubes")
	if len(Globals.shapes) != len(cubes):
		return false
	return true

func update_camera_follow():
	var node = get_lowest_node()
	if !node:
		return
	
	var cam_parent = cam.get_parent()
	
	if cam_parent:
		cam_parent.remove_child(cam)
	
	node.add_child(cam)
	
func get_lowest_node() ->Node2D:
	var nodes = get_tree().get_nodes_in_group("Cubes")
	
	if !nodes:
		return null
	
	var lowest = nodes[0]
	
	for node in nodes:
		lowest = node if node.position.y < lowest.position.y else lowest
		
	return lowest
