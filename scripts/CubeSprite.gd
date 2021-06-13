extends Sprite

var _type setget set_type, get_type

func set_type(type):
	_type = type
	match type:
		"square":
			texture = load("res://assets/white_sq.png")
		"circle":
			texture = load("res://assets/white_cir.png")
		"triangle":
			texture = load("res://assets/white_tri.png")
		"star":
			texture = load("res://assets/white_sta.png")

func get_type():
	return _type
