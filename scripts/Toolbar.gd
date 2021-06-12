extends Node2D

const Cube = preload("res://scenes/Cube.tscn")

var shapes = {
	"square": 1,
	"circle": 2,
	"triangle": 1,
	"star": 2
}

var colors = [
	'e82222',
	'261bed',
	'29b719',
	'b719d3'
]

func _ready():
	var last_y = 0
	for shape in shapes:
		var num = int(shapes[shape])
		for i in range(0, num):
			var cube = Cube.instance()
			cube.color = colors[randi() % colors.size()]
			cube.position.y = last_y * cube.tile_size
			last_y += 1
			
			add_child(cube)
			
			cube.sprite.set_type(shape)
