extends Node2D

const Cube = preload("res://scenes/Cube.tscn")


func _ready():
	var last_y = 0
	for shape in Globals.shapes:
		var cube = Cube.instance()
		cube.color = Globals.colors[shape["color"]]
		cube.position.y = last_y * cube.tile_size
		last_y += 1
		
		add_child(cube)
		
		cube.sprite.set_type(shape["shape"])
