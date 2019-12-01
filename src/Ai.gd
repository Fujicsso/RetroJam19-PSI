extends KinematicBody2D

onready var world = get_parent()

const BAR_TIME = 2
const MOVE_SPEED = 200
const MAX_TIME_COL_GAJO = 3 # 3 secs for game over
# const TURN_ANGLE = PI / 64

var goingToBar = false
var atBar = false
var returningFromBar = false
var reachedBar = 0
var totalTime = 0
var sinceLastEvent = 0
var timeCollindingWithGajo = 0


# Declare member variables here. Examples:
var angle = PI / 2
var reverse = 1
var time = 0
var lastMoveAngle = null
var speed = 150
var bar_position = Vector2()
var init_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	init_position = self.get_position()
	set_physics_process(true)

func _calc_bar_position(player_position):
	if player_position.x < 0 and player_position.y < 0:
		var bar = get_node("../Bar")
		return bar.get_position()
	elif player_position.x > 0 and player_position.y < 0:
		var bar = get_node("../Bar2")
		return bar.get_position()
	elif player_position.x > 0 and player_position.y > 0:
		var bar = get_node("../Bar3")
		return bar.get_position()
	elif player_position.x < 0 and player_position.y > 0:
		var bar = get_node("../Bar4")
		return bar.get_position()


func _check_colliding_with_gajo(delta):
	timeCollindingWithGajo += delta
	if timeCollindingWithGajo > MAX_TIME_COL_GAJO:
		world.worldState = world.worldEvent.END


func _normal_action(delta):
	var player_position = null
	var Move = Vector2()
	var self_position = null
	
	if goingToBar:
		player_position = self.get_position()
		var distance = player_position.distance_to(bar_position)
		Move = bar_position - player_position
		Move = Move.normalized()
		global_rotation = Move.angle()
		if move_and_collide(Move) != null:
			reachedBar = totalTime
			goingToBar = false
			atBar = true

	elif atBar:
		if totalTime - reachedBar > 5:
			atBar = false
			returningFromBar = true

	elif returningFromBar:
		player_position = self.get_position()
		if player_position.distance_to(init_position) < 5:
			returningFromBar = false
		else:
			Move = init_position - player_position
			Move = Move.normalized()
			move_and_collide(Move)
			global_rotation = Move.angle()

	else:
		if sinceLastEvent > 5:
			sinceLastEvent = 0
			var chance = randi() % 101 + 1
			# 20 for debugging, around 5 when final
			if chance <= 20:
				goingToBar = true
				player_position = self.get_position()
				bar_position = _calc_bar_position(player_position)

	if(time > 0.5):
		time = 0
		if(reverse == -1):
			reverse = 1
		elif(reverse == 1):
			reverse = -1
#	if lastMoveAngle != null:
#		print("entrei aqui")
#		angle += reverse*(PI/4) * delta * 1.5
#		global_rotation = angle + lastMoveAngle
#	else:
	angle += reverse * (PI/4) * delta * 1.5
	global_rotation = angle

func _physics_process(delta):
	var player_position = null
	var Move = Vector2()
	var self_position = null
	var body = get_node("body").get_overlapping_bodies()

	sinceLastEvent += delta
	totalTime += delta
	time += delta

	if body.size() != 0:
		for tinge in body:
			if tinge.is_in_group("Gajo"):
				player_position = tinge.get_position()
				self_position = self.get_position()
				Move =  player_position - self_position
				Move = Move.normalized()
				global_rotation = Move.angle()
				move_and_collide(Move * speed * delta)
				_check_colliding_with_gajo(delta)
	
	if world.worldState == world.worldEvent.CLOSING_HOUR:
		goingToBar = true
		bar_position = Vector2(0, 1000)
		_normal_action(delta)

	if world.groovy_time():
		goingToBar = true
		bar_position = Vector2(0, 0)
		_normal_action(delta)

	else:
		if world.happy_hour():
			goingToBar = true
			bar_position = _calc_bar_position(self.get_position())
		_normal_action(delta)

func kill():
	get_tree().reload_current_scene()

