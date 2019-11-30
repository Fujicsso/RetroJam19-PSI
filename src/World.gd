extends Node2D

# Declare member variables here. Examples:
var last = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delta - last > 1.0:
		print_debug("spawn enemy")
		last = delta
