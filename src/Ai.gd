extends KinematicBody2D

onready var world = get_parent()

const bar_position = Vector2(-200, -20)
# onready const bar_position = world.bar.position

const BAR_TIME = 2
const MOVE_SPEED = 200
# const TURN_ANGLE = PI / 64

var goingToBar = true
var reachedBar = 0
var totalTime = 0
var sinceLastEvent = 0
var delta_X = 0
var delta_Y = 0


# Declare member variables here. Examples:
var angle = PI / 2
var reverse = 1
var time = 0
var speed = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)


func _physics_process(delta):
	var Move = Vector2()
	var player_position = null
	var self_position = null
	var body = get_node("body").get_overlapping_bodies()

	if body.size() != 0:
		for tinge in body:
			if tinge.is_in_group("Gajo"):
				player_position = tinge.get_position()
				self_position = self.get_position()
				
				
	if player_position != null && self_position != null :
		Move =  player_position - self_position
		Move = Move.normalized()
		global_rotation = Move.angle()
		move_and_collide(Move * speed * delta)
	
#	sinceLastEvent += delta
#	totalTime += delta
#	time += delta
#	var position = get_position()
#	var move_vec = Vector2()
#
#	var Move = Vector2()
#	var player_position = null
#	var self_position = null
#	var body = get_node("body").get_overlapping_bodies()
#
#	if body.size() != 0:
#		for tinge in body:
#			if tinge.is_in_group("Gajo"):
#				player_position = tinge.get_position()
#				self_position = self.get_position()
#
#
#	if player_position != null && self_position != null :
#		Move =  player_position - self_position
#		Move = Move.normalized()
#		global_rotation = Move.angle()
#		move_and_collide(Move * MOVE_SPEED * delta)
			

#	if goingToBar:
#		var distance = position.distance_to(bar_position)
#		if distance < 10:
#			reachedBar = totalTime
#			goingToBar = false
#		move_vec = bar_position - position
#		move_vec = move_vec.normalized()
#
#	else:
#		if sinceLastEvent > 1:
#			sinceLastEvent = 0
#			var chance = randi() % 101 + 1
#			if chance <= 5:
#				goingToBar = true
#
#	# DANCE DANCE REVOLUTION
#	if(time > 0.5):
#		time = 0
#		if(reverse == -1):
#			reverse = 1
#		elif(reverse == 1):
#			reverse = -1
#
#
#
#	angle += reverse*(PI/4) * delta * 1.5
#	global_rotation = angle

func kill():
	get_tree().reload_current_scene()

