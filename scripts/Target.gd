extends Area2D

export (Globals.Shapes) var shape
export (Globals.Colors) var color

onready var sprite = $Sprite
onready var timer = $Timer

const atlas_texture = preload("res://assets/targets_atlas.png")
var atlas = AtlasTexture.new()
var correct_match = false

func _ready():
	sprite.modulate = Color(_get_color_value())
	atlas.set_atlas(atlas_texture)
	atlas.region  = get_region_by_shape()
	sprite.texture = atlas

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

func _get_color_value():
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
	return color_val

func _get_shape_value():
	return ['square', 'circle', 'triangle', 'star'][self.shape]

func _on_Target_body_entered(body):
	var shape_match = true if body.sprite.get_type() == self._get_shape_value() else false
	var color_match = true if body.color == self._get_color_value() else false
	
	if shape_match and color_match:
		correct_match = true
	
	timer.start(3)

func _on_Target_body_exited(body):
	timer.stop()
	
func _on_Timer_timeout():
	timer.stop()
	if correct_match:
		print("This slot is correclty filled")
	else:
		print("This slot was incorrectly filled")

