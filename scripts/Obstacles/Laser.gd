extends Area2D

export (Globals.Colors) var color = 0

onready var sprite = $AnimatedSprite

func _ready():
	sprite.modulate = Globals.colors[color]
	set_collision_mask_bit( (color + 1) * 10 , true)


func _on_Laser_body_entered(body):
	print(body, ' collided')
	# Destroy body if collision occures
	body.destroy()
