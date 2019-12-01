extends Node2D

var audio = preload("res://Music&SndEffects/Game Over.wav")

onready var musicPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	musicPlayer.stream = audio
	musicPlayer.play()