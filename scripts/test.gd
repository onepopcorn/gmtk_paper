extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_point(Vector2(1.0, 1.0))
	add_point(Vector2(2.0, 2.0))
	print(get_point_count())
	z_index = 100000
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
