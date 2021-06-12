extends RigidBody2D


signal clicked

var held = false
var tile_size: = 64

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)


func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()
		# position.snapped(Vector2.ONE * tile_size)
		
func pickup():
	if held:
		return
		
	mode = RigidBody2D.MODE_STATIC
	held = true
	
	
func drop():
	if held:
		# mode = RigidBody2D.MODE_RIGID
		# apply_central_impulse(impulse)
		held = false


func _on_Cube_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
