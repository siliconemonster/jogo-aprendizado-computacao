extends KinematicBody2D

export var moveSpeed: = 600.0

var velocity: = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	var movementDirection: = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	velocity = movementDirection * moveSpeed
	velocity = move_and_slide(velocity)
	faceMovementDirection()
	
	
func faceMovementDirection() -> void:
	if velocity.x > 0: 
		get_node("playerSpriteIdle").set_flip_h(true)
	else:
		if velocity.x < 0:
			get_node("playerSpriteIdle").set_flip_h(false)
