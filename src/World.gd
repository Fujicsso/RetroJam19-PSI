extends Node2D

# in seconds
const SPAWN_TIME = 10

# Declare member variables here. Examples:
var lastSpawn = 0
var curr = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	curr += delta
	if curr - lastSpawn > SPAWN_TIME:
		print_debug("spawn enemy")
		lastSpawn = curr
