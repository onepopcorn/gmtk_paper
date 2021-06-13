extends Node

var is_dragging: = false
var is_playing : = false

enum Colors {
	Red,
	Blue,
	Green,
	Purple
}

var colors = [
	'e82222',
	'261bed',
	'29b719',
	'b719d3'
]

enum Shapes {
	square,
	circle,
	triangle,
	star
}

var shapes = {
	"square": 1,
	"circle": 0,
	"triangle": 0,
	"star": 0
}

var n_cubes = shapes["square"] + shapes["circle"] + shapes["triangle"] + shapes["star"]
