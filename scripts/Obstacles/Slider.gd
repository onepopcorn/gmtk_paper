extends RigidBody2D

export (Globals.Colors) var color = 0

onready var sprite = $Sprite

func _ready():
	self.mode = RigidBody2D.MODE_STATIC
	sprite.modulate = Globals.colors[color]
	set_collision_mask_bit( (color + 1) * 10 , true)
