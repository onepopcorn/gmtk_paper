extends RigidBody2D

signal joinCubesStart(node)
signal joinCubesStop(node)

export (Color) var color = Color(0,0,0)

enum STATE {
	EDIT,
	GAME
}

var tile_size = 48
var dragging = false
var state = STATE.EDIT
var is_valid_position = false
var init_position

onready var player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")

func _ready():
	snapToGrid()
	
	# Play square animation and prevent all cubes have the same animation (starting from a random frame)
	player.play("Square")
	player.seek(randi() % 5)
	
	# Set square color
	sprite.modulate = color
	
	# Keep track of initial position
	init_position = Vector2(position)

func _process(_delta):
	if dragging:
		global_transform.origin = get_global_mouse_position()
	

func _on_mouse_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
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

func drop():
	if not dragging:
		return
	
	dragging = false
	
	if !is_valid_position:
		position = init_position
		snapToGrid()
		return
	
	# Move cube from toolbar to main
	var root = get_tree().get_root()
	get_parent().remove_child(self)
	root.add_child(self)
	
	# Get new context absolute position
	global_transform.origin = get_global_mouse_position()
	
	# Get a new init position for further illegal moves
	init_position = Vector2(position)
	
	snapToGrid()
	

func snapToGrid():
	var vp_rect = get_viewport_rect()
	
	position.x = clamp(position.x, 0, vp_rect.size.x)
	position.y = clamp(position.y, 0, vp_rect.size.y)
	
	var tileNum = (position / tile_size).floor()
	position = tileNum * tile_size + Vector2.ONE * tile_size / 2
