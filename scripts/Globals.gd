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

var shapes = [
	{"shape": "square", "color": Colors.Blue},
	{"shape": "circle", "color": Colors.Blue},
	{"shape": "triangle", "color": Colors.Green},
]

