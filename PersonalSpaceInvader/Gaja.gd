extends KinematicBody2D

onready var world = get_parent()

const MOVE_SPEED = 180
const TURN_ANGLE = PI / 64
var look_direction = Vector2(1, 0);
var speed = 0

# Declare member variables here. Examples:
var angle = PI

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("run-anim")

func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up_run"):
		if speed == 0:
			$AnimatedSprite.play("run-anim")
		speed = 1
	elif Input.is_action_pressed("move_down_run"):
		if speed == 0:
			$AnimatedSprite.play("run-anim")
		speed = -1
	else:
		speed = 0
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
	if Input.is_action_pressed("move_left_run"):
		angle -= TURN_ANGLE
	if Input.is_action_pressed("move_right_run"):
		angle += TURN_ANGLE
	
	if Input.is_action_just_pressed("run_ability"):
		world.use_chase_ability(self.get_position())

	move_vec = Vector2(speed * cos(angle), speed * sin(angle))
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * MOVE_SPEED * delta)
	global_rotation = angle

func kill():
	if get_tree().reload_current_scene() != null:
		$AnimatedSprite.stop()
