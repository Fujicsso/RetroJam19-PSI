
extends KinematicBody2D

const MOVE_SPEED = 180
const TURN_ANGLE = PI / 64

# Declare member variables here. Examples:
var angle = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var move_vec = Vector2()
	var speed = 0
	if Input.is_action_pressed("move_up_chase"):
		speed = 1
	if Input.is_action_pressed("move_down_chase"):
		speed = -1
	if Input.is_action_pressed("move_left_chase"):
		angle -= TURN_ANGLE
	if Input.is_action_pressed("move_right_chase"):
		angle += TURN_ANGLE

	move_vec = Vector2(speed * cos(angle), speed * sin(angle))
	move_vec = move_vec.normalized()
	if move_and_collide(move_vec * MOVE_SPEED * delta) == null:
		global_rotation = angle
	else:
		global_rotation = angle

func kill():
	if get_tree().reload_current_scene() != null:
		print("Oof")
