extends Node2D

# in seconds
const SPAWN_TIME = 10
const CHASE_COOLDOWN = 10
const RUN_COOLDOWN = 10
const CHASE_DURATION = 5
const RUN_DURATION = 5

var chase_available = true
var chase_ability = false
var chase_last_used = 0
var chase_ability_pos = Vector2()

var run_available = true
var run_ability = false
var run_last_used = 0
var run_ability_pos = Vector2()

enum worldEvent {
	DEFAULT,
	HAPPY_HOUR,
	GROOVY_TIME,
	CLOSING_HOUR,
	END
}

var worldState = worldEvent.DEFAULT
var total = 0

func use_chase_ability(position):
	if chase_available:
		chase_available = false
		chase_ability = true
		chase_last_used = total
		chase_ability_pos = position

func use_run_ability(position):
	if run_available:
		run_available = false
		run_ability = true
		run_last_used = total
		run_ability_pos = position

func check_abilities():
	if total - chase_last_used > CHASE_DURATION:
		chase_ability = false
	if total - chase_last_used > CHASE_DURATION + CHASE_COOLDOWN:
		chase_available = true
	if total - run_last_used > RUN_DURATION:
		run_ability = false
	if total - run_last_used > RUN_DURATION + RUN_COOLDOWN:
		run_available = true

func within_radius(pos1, pos2, rad):
	return pos1.distance_to(pos2) < rad

func get_ability(player_position, radius):
	check_abilities()
	if chase_ability and not run_ability and within_radius(player_position, chase_ability_pos, radius):
		return chase_ability_pos
	elif run_ability and not chase_ability and within_radius(player_position, run_ability_pos, radius):
		return run_ability_pos
	elif chase_ability and run_ability:
		if within_radius(player_position, chase_ability_pos, radius) and within_radius(player_position, run_ability_pos, radius):
			if run_last_used > chase_last_used:
				return run_ability_pos
			else:
				return chase_ability_pos
		elif within_radius(player_position, chase_ability_pos, radius):
			return chase_ability_pos
		elif within_radius(player_position, run_ability_pos, radius):
			return run_ability_pos
		else:
			return null
	else:
		return null

func groovy_time():
	return worldState == worldEvent.GROOVY_TIME

func happy_hour():
	return worldState == worldEvent.HAPPY_HOUR

func closing_hour():
	return worldState == worldEvent.CLOSING_HOUR

const firstEvent = worldEvent.HAPPY_HOUR
const secondEvent = worldEvent.GROOVY_TIME

func event_handler():
	match worldState:
		worldEvent.DEFAULT:
			if total > 5 && total < 15:
				worldState = firstEvent
			elif(total > 25 && total < 40):
				worldState = secondEvent
			elif(total > 50 && total < 65):
				worldState = worldEvent.CLOSING_HOUR
		firstEvent:
			if(total > 15):
				worldState = worldEvent.DEFAULT
		secondEvent:
			if(total > 40):
				worldState = worldEvent.DEFAULT
		worldEvent.CLOSING_HOUR:
			if(total > 65):
				worldState = worldEvent.END

# Declare member variables here. Examples:
var lastSpawn = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	total += delta
	event_handler()
	#print(total ,  ' ----  ' ,  worldState)
	if total - lastSpawn > SPAWN_TIME:
		print_debug("spawn enemy")
		lastSpawn = total
