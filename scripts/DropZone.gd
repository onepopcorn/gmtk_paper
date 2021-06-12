extends Area2D


func _on_DropZone_body_entered(body):
	body.is_valid_position = true
	
	if body.dragging:
		modulate = Color(0,0,0,0.3)


func _on_DropZone_body_exited(body):
	body.is_valid_position = false
	modulate = Color(0,0,0,1)
