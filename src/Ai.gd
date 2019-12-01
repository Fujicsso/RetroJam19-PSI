extends KinematicBody2D

onready var world = get_parent()

const bar_position = Vector2(-200, -20)
# onready const bar_position = world.bar.position

const BAR_TIME = 2
const MOVE_SPEED = 200
# const TURN_ANGLE = PI / 64

var goingToBar = false
var reachedBar = 0
var totalTime = 0
var sinceLastEvent = 0



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
	sinceLastEvent += delta
    
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
					player_position = self.get_position()
					var distance = player_position.distance_to(bar_position)
					if distance < 10:
						reachedBar = totalTime
						goingToBar = false
					Move = bar_position - player_position
					Move = Move.normalized()
					move_and_collide(Move)
			
				else:
					if sinceLastEvent > 5:
						sinceLastEvent = 0
						var chance = randi() % 101 + 1
						if chance <= 5:
							goingToBar = true
							player_position = self.get_position()
							var bar_position = Vector2()
							if player_position.x < 0 and player_position.y < 0:
								var bar = get_node("../Bar")
								bar_position = bar.get_position()
							elif player_position.x > 0 and player_position.y < 0:
								var bar = get_node("../Bar2")
								bar_position = bar.get_position()
							elif player_position.x > 0 and player_position.y > 0:
								var bar = get_node("../Bar3")
								bar_position = bar.get_position()
							elif player_position.x < 0 and player_position.y > 0:
								var bar = get_node("../Bar4")
								bar_position = bar.get_position()
							print(bar_position)
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
				angle += reverse*(PI/4) * delta * 1.5
				global_rotation = angle
	

func kill():
	get_tree().reload_current_scene()

