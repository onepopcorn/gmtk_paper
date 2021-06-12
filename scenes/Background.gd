extends Node2D

enum PIPE_TYPE {
	DOWN,
	UP,
	# BOTH
}

const BG_TEX :Texture = preload("res://assets/bg_tile.png")
const PIPE_CLASS = preload("res://scenes/Pipe.tscn")
const TILES :int = 4
const FPS :int = 60
const PIPE_TOP_LIMIT = -500
const PIPE_BOTTOM_LIMIT = 800

onready var vp = get_viewport()
var total_width :int = 0
var pipes = []
var spawn_time = 5 #seconds
var timer = 0

func _ready():
	# Set total width based on tile height
	total_width = BG_TEX.get_width() * TILES
	
	# Create background loop
	for i in range(0,TILES):
		var t :Sprite = Sprite.new()
		t.texture = BG_TEX
		t.position.x = t.texture.get_width() * i
		t.position.y = vp.size.y  - t.texture.get_height() * 0.5
		add_child(t)
	
		
func _physics_process(_delta):
	# Scroll background image
	for i in range(0,TILES):
		var t :Sprite = get_child(i)

		if t.position.x < t.texture.get_width() * -1:
			t.position.x = total_width + t.position.x

		t.position.x -= Globals.game_speed
	
	# Scroll & remove pipes when needed
	for i in range(pipes.size(), 0, -1):
		var pipe = pipes[i-1]
		
		if pipe.position.x < -50:
			print("kill pipe ", i)
			pipes.remove(i-1)
			remove_child( pipe )
			pipe.queue_free()
		else:
			pipe.position.x -= Globals.game_speed
			
	# Decide if a pipe needs to be spawned
	if timer == spawn_time * FPS:
		spawn_pipe()
		timer = 0
	else:
		timer += Globals.game_speed
		

func spawn_pipe():
	var type = PIPE_TYPE.values()[ randi()%PIPE_TYPE.size() ]
	create_pipe(type)
	
	
func create_pipe(type):
	print(type)
	
	var pipe = PIPE_CLASS.instance()
	var pipe_h = pipe.get_node("Sprite").texture.get_height()
	var yPos = 0

	match type:
		PIPE_TYPE.UP:
			yPos = min( randi() % int(pipe_h) + vp.size.y, PIPE_BOTTOM_LIMIT)
		PIPE_TYPE.DOWN:
			var sprite = pipe.get_node("Sprite")
			sprite.flip_v = true
			yPos = max( pipe_h - randi() % int(vp.size.y), PIPE_TOP_LIMIT)
		PIPE_TYPE.BOTH:
			pass
	
	print(">>", yPos)
	
	# Common actions		
	pipe.position.x = vp.size.x + 50
	pipe.position.y = yPos
	add_child(pipe)
	pipes.append(pipe)
			
			
