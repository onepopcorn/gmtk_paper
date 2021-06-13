extends Area2D

export (Globals.Colors) var color = 0

onready var sprite = $Sprite

func _ready():
	sprite.modulate = Globals.colors[color]
	set_collision_mask_bit( (color + 1) * 10 , true)
	

func _on_Area2D_body_entered(body):
	body.freeze()
