extends KinematicBody2D

export var moveSpeed: = 600.0

var velocity: = Vector2.ZERO

var _isFullRunning = false

func _physics_process(delta: float) -> void:
	movement()
	spriteAnimation()

func movement():
	var movementDirection: = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	velocity = movementDirection.normalized() * moveSpeed    #normalized movement direction so diagonal movement is not faster than it should be
	velocity = move_and_slide(velocity)


func spriteAnimation():
	if velocity.x > 0:
		$AnimatedSprite.set_flip_h(true)
	else:
		if velocity.x < 0:
			$AnimatedSprite.set_flip_h(false)
	
	if velocity.length() > 0:
		if not _isFullRunning:
			$AnimatedSprite.play("idleToMoving")
			if $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count("idleToMoving") - 1:
				_isFullRunning = true
		else:
			$AnimatedSprite.play("moving")
	else:
		_isFullRunning = false
		$AnimatedSprite.play("idle")
