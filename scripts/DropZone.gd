extends Area2D


func _on_DropZone_body_entered(body):
	body.is_valid_position = true


func _on_DropZone_body_exited(body):
	body.is_valid_position = false
