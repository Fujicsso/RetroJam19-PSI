extends Node2D

onready var musicPlayer = get_node("../../../../Music")

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
			if total > 20 && total < 30:
				musicPlayer.changeMusic(musicPlayer.musicEvent.HAPPY_HOUR)
				worldState = firstEvent
			elif(total > 40 && total < 60):
				musicPlayer.changeMusic(musicPlayer.musicEvent.GROOVY_TIME)
				worldState = secondEvent
			elif(total > 75 && total < 82):
				musicPlayer.changeMusic(musicPlayer.musicEvent.CLOSING_HOUR)
				worldState = worldEvent.CLOSING_HOUR
		firstEvent: # happy hour
			if(total > 30):
				musicPlayer.changeMusic(musicPlayer.musicEvent.DEFAULT)
				worldState = worldEvent.DEFAULT
		secondEvent: # groovy time
			if(total > 60):
				musicPlayer.changeMusic(musicPlayer.musicEvent.DEFAULT)
				worldState = worldEvent.DEFAULT
		worldEvent.CLOSING_HOUR:
			if(total > 82):
				worldState = worldEvent.END
		worldEvent.END:
			get_tree().change_scene("res://GameOverScreen.tscn")
			worldState = worldEvent.DEFAULT

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
		lastSpawn = total
