extends KinematicBody2D

export var moveSpeed: = 600.0
var _objectCurrentlyHeld = null

var velocity: = Vector2.ZERO

var _facingDirection = -1 # 1: facing right // -1: facing left
var _isFullyMoving = false # used in animation only

var _interactableBodiesInRange = []


# Adds and removes interactable objects from _interactableBodiesInRange array as they enter/exit the InteractableArea
func _on_InteractableArea_body_entered(body: Node) -> void:
	_interactableBodiesInRange.append(body)
func _on_InteractableArea_body_exited(body: Node) -> void:
	_interactableBodiesInRange.erase(body)


func _physics_process(delta: float) -> void:
	movement()
	packageManipulation()
	flipNodesBasedOnFacingDirection()
	spriteMovementAnimation()

func movement():
	
	# Gets movementDirection from Input:
	var movementDirection: = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	# Normalized movementDirection so diagonal movement is not faster than it should be:
	velocity = movementDirection.normalized() * moveSpeed
	
	# Moves:
	velocity = move_and_slide(velocity)
	
	# Updates _facingDirection:
	if velocity.x > 0:
		_facingDirection = 1
	elif velocity.x < 0:
		_facingDirection = -1

	return
	
	
func packageManipulation():
	if _objectCurrentlyHeld == null and Input.is_action_just_pressed("interact"):
		grabPackage()
	elif _objectCurrentlyHeld != null and Input.is_action_just_pressed("interact"):
		dropPackage()
	
	# Keeps object in front of Player while being held:
	if _objectCurrentlyHeld != null:
		_objectCurrentlyHeld.position = position + Vector2(0, 10)
	
	
func grabPackage():
	var target = _interactableBodiesInRange.pop_front()
	if target == null:
		return
	_objectCurrentlyHeld = target
	_objectCurrentlyHeld.find_node("CollisionShape2D").disabled = true
	_objectCurrentlyHeld.z_index = 1 # move object sprite render to be in front of player sprite
	return

func dropPackage():
	_objectCurrentlyHeld.position = position + Vector2(10 * _facingDirection, 7)
	_objectCurrentlyHeld.find_node("CollisionShape2D").disabled = false
	_objectCurrentlyHeld.z_index = 0 # move object sprite render to be behind of player sprite
	_objectCurrentlyHeld = null
	return


func flipNodesBasedOnFacingDirection():
	# Facing Right:
	if _facingDirection == 1:
		$PlayerSprite.set_flip_h(true)
		$InteractableArea.position = Vector2(10, 34)
		if _objectCurrentlyHeld != null:
			_objectCurrentlyHeld.find_node("Sprite").set_flip_h(true)
	# Facing Left:
	elif _facingDirection == -1:
			$PlayerSprite.set_flip_h(false)
			$InteractableArea.position = Vector2(-10, 34)
			if _objectCurrentlyHeld != null:
				_objectCurrentlyHeld.find_node("Sprite").set_flip_h(false)
	return


func spriteMovementAnimation():
	if velocity.length() > 0:
		if not _isFullyMoving:
			$PlayerSprite.play("idleToMoving")
			# If on last frame of transitional animation, start full moving animation:
			if $PlayerSprite.frame == $PlayerSprite.frames.get_frame_count("idleToMoving") - 1:
				_isFullyMoving = true
		else:
			$PlayerSprite.play("moving")
	else:
		_isFullyMoving = false
		$PlayerSprite.play("idle")
	return
