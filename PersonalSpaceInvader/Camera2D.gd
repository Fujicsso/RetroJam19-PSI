extends Camera2D

var target = null

func _physics_process(delta):
	if target:
		position = Vector2(target.position.x + 530, target.position.y + 310)
