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

const firstEvent = worldEvent.GROOVY_TIME
const secondEvent = worldEvent.HAPPY_HOUR

func event_handler():
	match worldState:
		worldEvent.DEFAULT:
			if total > startOfEvents:
				worldState = firstEvent
			elif(total > startOfEvents + 45):
				worldState = secondEvent
			elif(total > startOfEvents + 90):
				worldState = worldEvent.CLOSING_HOUR
		firstEvent:
			if(total > startOfEvents + 15):
				worldState = worldEvent.DEFAULT
		secondEvent:
			if(total > startOfEvents + 60):
				worldState = worldEvent.DEFAULT
		worldEvent.CLOSING_HOUR:
			if(total > startOfEvents + 135):
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
	if total - lastSpawn > SPAWN_TIME:
		print_debug("spawn enemy")
		lastSpawn = total
