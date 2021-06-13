extends Area2D

export (Globals.Shapes) var shape
export (Globals.Colors) var color

onready var sprite = $Sprite

func _ready():
	var color_val = 'e82222'
	match color:
		Globals.Colors.Red:	
			color_val = 'e82222'
		Globals.Colors.Blue:
			color_val = '261bed'
		Globals.Colors.Green:
			color_val = '29b719'
		Globals.Colors.Purple:
			color_val = 'b719d3'
	
	sprite.modulate = Color(color_val)
	sprite.texture.region = get_region_by_shape()

func get_region_by_shape()->Rect2:
	var region = Rect2(0, 0, 50, 48)
	match shape:
		Globals.Shapes.square:
			region.position.x = 0
		Globals.Shapes.triangle:
			region.position.x = 50
		Globals.Shapes.circle:
			region.position.x = 50 * 2
		Globals.Shapes.star:
			region.position.x = 50 * 3
			
	return region
