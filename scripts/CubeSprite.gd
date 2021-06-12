extends Sprite

func set_type(type):
	match type:
		"square":
			texture = load("res://assets/white_sq.png")
		"circle":
			texture = load("res://assets/white_cir.png")
		"triangle":
			texture = load("res://assets/white_tri.png")
		"star":
			texture = load("res://assets/white_sta.png")
