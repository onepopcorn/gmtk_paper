extends Node2D


# There is a typo
onready var lose = $Loose
onready var win = $Win

func display_win():
	visible = true
	win.visible = true

func display_lose():
	lose.visible = true
	visible = true


func _on_TextureButton_pressed():
	get_node("/root/Main").replay()
