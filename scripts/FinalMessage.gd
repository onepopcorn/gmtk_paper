extends Node2D


onready var loose = $Loose
onready var win = $Win

func show_message(win):
	if win:
		win.visible = true
	else:
		win.visible = false
	
