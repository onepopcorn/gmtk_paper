extends Area2D

var tile_size = 48
var dragging = false
onready var player = get_node("AnimationPlayer")

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2
	player.play("Square")
	

func _process(delta):
	if dragging:
		print( get_viewport().get_mouse_position() )
		set_position( get_viewport().get_mouse_position() )


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			dragging = true
		else:
			dragging = false
			position = position.snapped(Vector2.ONE * tile_size)
			position += Vector2.ONE * tile_size / 2
