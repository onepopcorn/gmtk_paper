extends Node2D

const Cube = preload("res://scenes/Cube.tscn")


func _ready():
	# Use this to create real randomness
	randomize()
	var last_y = 0
	for shape in Globals.shapes:
		var num = Globals.shapes[shape]
		for i in range(0, num):
			var cube = Cube.instance()
			cube.color = Globals.colors[randi() % Globals.colors.size()]
			cube.position.y = last_y * cube.tile_size
			last_y += 1
			
			add_child(cube)
			
			cube.sprite.set_type(shape)
