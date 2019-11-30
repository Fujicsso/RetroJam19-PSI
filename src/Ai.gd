extends KinematicBody2D

const MOVE_SPEED = 180
const TURN_ANGLE = PI / 64

# Declare member variables here. Examples:
var angle = PI / 2
var time = 0
var reverse = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	
	time += delta
	if(time > 0.5):
		time = 0
		if(reverse == -1):
			reverse = 1
		elif(reverse == 1):
			reverse = -1
	
	angle += reverse*(PI/4) * delta * 1.5
	global_rotation = angle

func kill():
	get_tree().reload_current_scene()

