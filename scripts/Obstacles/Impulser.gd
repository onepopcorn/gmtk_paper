extends Area2D


export (Globals.Colors) var color = 0

onready var sprite = $Sprite

func _ready():
	sprite.modulate = Globals.colors[color]
	set_collision_mask_bit( (color + 1) * 10 , true)
	

func _on_Area2D_body_entered(body):
	var orientation = Vector2(sin(global_rotation), -cos(global_rotation))
	print("Orientation: ", orientation)
	var body_orientation = Vector2(sin(body.global_rotation), -cos(body.global_rotation))
	print("Body orientation: ", body_orientation)
	var rel_angle = body_orientation.angle_to(orientation)
	print("Rel angle", rel_angle * 180 / PI)
	var impulse_direction = body_orientation.rotated(rel_angle)
	
	body.apply_central_impulse(400 * impulse_direction)
