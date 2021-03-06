extends RigidBody2D

signal joinCubesStart(node)
signal joinCubesStop(node)

export (Color) var color = Color(0,0,0)

var tile_size = 48
var dragging = false
var is_valid_position = false
var init_position

onready var player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")

signal cube_destroyed
signal cube_frozen

func _ready():
	position = getSnappedPosition(position)
	
	# Play square animation and prevent all cubes have the same animation (starting from a random frame)
	player.play("Square")
	player.seek(randi() % 5)
	
	# Set square color
	sprite.modulate = color
	
	# Set collision by color
	var coll_layer = (Globals.colors.find(color) + 1) * 10
	set_collision_layer_bit(coll_layer, true)
	
	# Keep track of initial position
	init_position = Vector2(position)

	dragging = false
	is_valid_position = false

func _process(_delta):
	if dragging:
		global_transform.origin = get_global_mouse_position()
	

func _on_mouse_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and !Globals.is_playing:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			pickup()

		if event.button_index == BUTTON_RIGHT:
			if event.is_pressed():
				emit_signal("joinCubesStart", self)
			else:
				emit_signal("joinCubesStop", self)

		if !event.is_pressed():
			drop()

func pickup():
	if dragging:
		return
	dragging = true
	if is_valid_position:
		get_node("/root/Main/DropZone").modulate = Color(0,0,0,0.3)

func drop():
	if not dragging:
		return
	
	dragging = false
	get_node("/root/Main/DropZone").modulate = Color(0,0,0,1)
	
	if !is_position_valid():
		position = getSnappedPosition(init_position)
		return
	
	# Move cube from toolbar to main
	var root = get_tree().get_root()
	get_parent().remove_child(self)
	root.add_child(self)
	
	# Add cubes to a group for easy retrieval
	add_to_group("Cubes")
	
	# Get new context absolute position
	global_transform.origin = get_global_mouse_position()
	
	position = getSnappedPosition(position)
	# Get a new init position for further illegal moves
	init_position = Vector2(position)
	
	
	
func is_position_valid() -> bool:
	if !is_valid_position:
		return false
	
	var snapped_position = getSnappedPosition(get_global_mouse_position())
	
	for cube in get_tree().get_nodes_in_group("Cubes"):
		if cube == self:
			continue
			
		if cube.position == snapped_position:
			return false
	
	return true
	

func getSnappedPosition(pos: Vector2) -> Vector2:
	var vp_rect = get_viewport_rect()
	
	pos.x = clamp(pos.x, 0, vp_rect.size.x)
	pos.y = clamp(pos.y, 0, vp_rect.size.y)
	
	# Calculate position through tile number
	var tileNum = (pos / tile_size).floor()
	return tileNum * tile_size + Vector2.ONE * tile_size / 2
	
func destroy():
	emit_signal("cube_destroyed", self)

func freeze():
	print("that should freeze the body")
	mode = RigidBody2D.MODE_KINEMATIC
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	emit_signal("cube_frozen", self)



