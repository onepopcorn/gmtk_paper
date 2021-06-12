extends Node

var is_dragging: = false
var is_playing : = false

var colors = [
	'e82222',
	'261bed',
	'29b719',
	'b719d3'
]

var shapes = {
	"square": 3,
	"circle": 1,
	"triangle": 1,
	"star": 2
}

var n_cubes = shapes["square"] + shapes["circle"] + shapes["triangle"] + shapes["star"]
