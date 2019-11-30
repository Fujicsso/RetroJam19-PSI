extends AnimatedSprite

onready var world = get_parent()

# Declare member variables here. Examples:
var hasStarted = false
var hasEnded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not hasStarted:
		if world.groovy_time():
			show()
			play("groovy-time")
			hasStarted = true

	elif not hasEnded:
		if not world.groovy_time():
			stop()
			hide()
			hasEnded = true
