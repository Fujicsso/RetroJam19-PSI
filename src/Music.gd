extends Node2D

var audioNormal = preload("res://Music&SndEffects/Pull The Lever (Personal Space Invader Theme).ogg")
var audioHappyHour = preload("res://Music&SndEffects/Happy Hour.ogg")
var audioGroovyTime = preload("res://Music&SndEffects/Groovy Time Final 15 sec.ogg")
var audioClosingHours = preload("res://Music&SndEffects/Happy Hour.ogg")

onready var musicPlayer = $AudioStreamPlayer

enum musicEvent {
	DEFAULT,
	HAPPY_HOUR,
	GROOVY_TIME,
	CLOSING_HOUR
}


func changeMusic(state):
	if state == musicEvent.DEFAULT:
		musicPlayer.stream = audioNormal
	elif state == musicEvent.HAPPY_HOUR:
		musicPlayer.stream = audioHappyHour
	elif state == musicEvent.GROOVY_TIME:
		musicPlayer.stream = audioGroovyTime
	elif state == musicEvent.CLOSING_HOUR:
		musicPlayer.stream = audioClosingHours
	
	musicPlayer.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	changeMusic(musicEvent.DEFAULT)