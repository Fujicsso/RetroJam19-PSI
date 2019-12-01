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
var lastMoveAngle = null
var speed = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)


func _physics_process(delta):
	var player_position = null
	var Move = Vector2()
	var self_position = null
	var body = get_node("body").get_overlapping_bodies()
    
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
			else:
				if goingToBar:
					var distance = position.distance_to(bar_position)
					if distance < 10:
						reachedBar = totalTime
						goingToBar = false
					Move = bar_position - position
					Move = Move.normalized()
			
				else:
					if sinceLastEvent > 1:
						sinceLastEvent = 0
						var chance = randi() % 101 + 1
						if chance <= 5:
							goingToBar = true
				if(time > 0.5):
					time = 0
					if(reverse == -1):
						reverse = 1
					elif(reverse == 1):
						reverse = -1
#				if lastMoveAngle != null:
#					print("entrei aqui")
#					angle += reverse*(PI/4) * delta * 1.5
#					global_rotation = angle + lastMoveAngle
#				else:
				angle += reverse*(PI/4) * delta * 1.8
				global_rotation = angle
	

func kill():
	get_tree().reload_current_scene()

