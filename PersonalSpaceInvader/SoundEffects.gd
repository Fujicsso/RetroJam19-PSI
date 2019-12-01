extends Node2D

var glassClincking = preload("res://Music&SndEffects/glass clinking fx.wav")
var fivesecSheer = preload("res://Music&SndEffects/5_Sec_Crowd_Cheer-Mike_Koenig-1562033255.wav")
var watchYourStep = preload("res://Music&SndEffects/Hey Watch Your Step Dude.wav")

onready var musicPlayer = $AudioStreamPlayer

func playWatchYourStep():
	musicPlayer.stream = watchYourStep
	musicPlayer.play()

func playGlassClincking():
	musicPlayer.stream = glassClincking
	musicPlayer.play()
	
func play5secSheer():
	musicPlayer.stream = fivesecSheer
	musicPlayer.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass