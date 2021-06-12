extends RigidBody2D

export (Color) var color = Color(0,0,0)

var tile_size = 48
var dragging = false

onready var player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")

func _ready():
	snapToGrid()
	
	mode = RigidBody2D.MODE_STATIC
	# Play square animation and prevent all cubes have the same animation (starting from a random frame)
	player.play("Square")
	player.seek(randi() % 5)
	
	# Set square color
	sprite.modulate = color

func _process(_delta):
	if dragging:
		global_transform.origin = get_global_mouse_position()
	

func _on_mouse_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			pickup()

		if !event.is_pressed():
			drop()
		
func pickup():
	if dragging:
		return
	mode = RigidBody2D.MODE_STATIC
	dragging = true

func drop():
	if not dragging:
		return
	mode = RigidBody2D.MODE_CHARACTER
	snapToGrid()
	dragging = false

func snapToGrid():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2
