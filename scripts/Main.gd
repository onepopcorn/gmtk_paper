extends Node2D

const Cube = preload("res://scenes/Cube.tscn")
const Union = preload("res://scenes/Union.tscn")

onready var union = Union.instance()
onready var cam = $Camera2D
onready var toolbar = $Toolbar
onready var btn = $PlayBtn

# Adding all the positions of all the cubes
var last_game_state
var game_started = false
var game_finished = false

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

func _ready():
	return
	# Prevent interactivty until camera finish animation
	toolbar.visible = false
	btn.disabled = true
	btn.visible = false
	
	cam.get_node("InitialPan").play("VerticalPan")


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
	
	last_game_state = Vector2(0,0)
	# makes things go BOOOM!
	for cube in cubes:
		cube.mode = RigidBody2D.MODE_RIGID
		cube.connect("cube_destroyed", self, "_on_cube_destroyed")
		cube.connect("cube_frozen", self, "_on_cube_frozen")
		
		# Give some physics properties to the falling pieces
		cube.set_friction(.3)
		cube.set_bounce(.3)
		last_game_state += cube.position
	
	
	update_camera_follow()
	game_started = true

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
		lowest = node if node.position.y > lowest.position.y else lowest
		
	return lowest
	
func _on_InitialPan_animation_finished(anim_name):
	toolbar.visible = true
	btn.disabled = true
	btn.visible = true

func has_player_won():
	for target in get_node("Field/Targets").get_children():
		if !target.correct_match:
			return false
	return true

func finish_game():
	print("Game finished")
	$CubesMovingCheck.stop()
	if has_player_won():
		print("player won")
	else:
		print("player lost")


func _on_CubesMovingCheck_timeout():
	if not game_started:
		return

	var current_game_state = Vector2(0,0)
	var cubes = get_tree().get_nodes_in_group("Cubes")
	for cube in cubes:
		current_game_state += cube.position
		
	if (last_game_state - current_game_state).length_squared() < 1:
		finish_game()
		return

	last_game_state = current_game_state
