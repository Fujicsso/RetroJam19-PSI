extends KinematicBody2D

const DISTANCE = 90

# Declare member variables here. Examples:
enum state {
	SERVING,
	MOVING
}
enum spot {
	LEFT,
	MID1,
	RIGHT,
	MID2
}
var lastMoved
var time
var currPosition
var currState
var distanceMoved = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	currState = state.SERVING
	time = 0
	lastMoved = 0
	currPosition = spot.LEFT
	$AnimatedSprite.play("pour-up")

func _get_move_vec():
	if currPosition == spot.LEFT or currPosition == spot.MID1:
		return Vector2(2, 0)
	elif currPosition == spot.RIGHT or currPosition == spot.MID2:
		return Vector2(-2, 0)

func _update_spot():
	currState = state.SERVING
	if currPosition == spot.LEFT:
		currPosition = spot.MID1
		return
	elif currPosition == spot.MID1:
		currPosition = spot.RIGHT
		return
	elif currPosition == spot.RIGHT:
		currPosition = spot.MID2
		return
	elif currPosition == spot.MID2:
		currPosition = spot.LEFT
		return

func _serving():
	return currState == state.SERVING
	
func _moving():
	return currState == state.MOVING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	
	if _serving():
		if time - lastMoved > 5.4:
			$AnimatedSprite.stop()
			distanceMoved = 0
			currState = state.MOVING

	elif _moving():
		if distanceMoved >= DISTANCE:
			_update_spot()
			lastMoved = time
			$AnimatedSprite.play("pour-up")
			if currPosition == spot.LEFT or currPosition == spot.RIGHT:
				global_rotation += PI
		else:
			move_and_collide(_get_move_vec())
			distanceMoved += 2

#	if time - lastMoved > 5.4:
#		$AnimatedSprite.stop()
#		lastMoved = time
#		move_and_collide(_get_move_vec())
#		_update_spot()
#		if currPosition == spot.LEFT or currPosition == spot.RIGHT:
#			global_rotation += PI
#		$AnimatedSprite.play("pour-up")
