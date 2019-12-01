extends Node2D

# in seconds
const SPAWN_TIME = 10

enum worldEvent {
	DEFAULT,
	HAPPY_HOUR,
	GROOVY_TIME,
	CLOSING_HOUR,
	END
}

var worldState = worldEvent.DEFAULT
var total = 0

const startOfEvents = 5

func groovy_time():
	if worldState == worldEvent.GROOVY_TIME:
		return true
	else:
		return false

func happy_hour():
	if worldState == worldEvent.HAPPY_HOUR:
		return true
	else:
		return false

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
