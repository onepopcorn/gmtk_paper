extends Camera2D


var _target_to_follow :Node2D setget set_target, get_target

func set_target(node):
	_target_to_follow = node
	
func get_target() ->Node2D:
	return _target_to_follow

func _process(_delta):
	if _target_to_follow:
		position.y = _target_to_follow.position.y
