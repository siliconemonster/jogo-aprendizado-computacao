extends KinematicBody2D

export var move_speed: = 600.0
var _package_currently_held = null

var velocity: = Vector2.ZERO

var _facing_direction = -1 # 1: facing right // -1: facing left
var _is_fully_moving = false # used in animation only

var _package_slots_in_range = []

# Adds and removes PackageSlots from _package_slots_in_range array as they enter/exit the InteractableArea
func _on_InteractableArea_body_entered(body: Node) -> void:
	_package_slots_in_range.append(body)
func _on_InteractableArea_body_exited(body: Node) -> void:
	_package_slots_in_range.erase(body)


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
	velocity = movementDirection.normalized() * move_speed
	
	# Moves:
	velocity = move_and_slide(velocity)
	
	# Updates _facing_direction:
	if velocity.x > 0:
		_facing_direction = 1
	elif velocity.x < 0:
		_facing_direction = -1

	return
	
	
func packageManipulation():
	if _package_currently_held == null and Input.is_action_just_pressed("interact"):
		grabPackage()
	elif _package_currently_held != null and Input.is_action_just_pressed("interact"):
		dropPackage()
	
	
func grabPackage():
	# Searches for a PackageSlot in range that is currently holding a Package:
	var target_slot = null
	for package_slot in _package_slots_in_range:
		if package_slot.package_held != null:
			target_slot = package_slot
			break
	if target_slot == null:
		return
	
	var package = target_slot.package_held
	
	# Reparents Package:
	target_slot.remove_child(package)
	self.add_child(package)
	
	# Updates Currently Held Package variable for both PackageSlot and Player:
	target_slot.package_held = null
	_package_currently_held = package
	
	# Updates Package Position:
	package.position = Vector2(0, 10)
	
	package.z_index = 3 # move object sprite render to be in front of player sprite
	return


func dropPackage():
	# Searches for a PackageSlot in range that is not currently holding a Package:
	var target_slot = null
	for package_slot in _package_slots_in_range:
		if package_slot.package_held == null:
			target_slot = package_slot
			break
	if target_slot == null:
		return
	
	var package = _package_currently_held
	
	# Reparents Package:
	self.remove_child(package)
	target_slot.add_child(package)
	
	# Updates Currently Held Package variable for both PackageSlot and Player:
	target_slot.package_held = package
	_package_currently_held = null
	
	# Updates Package Position:
	package.position = Vector2.ZERO
	
	package.z_index = 0 # move object sprite render to be behind of player sprite
	return


func flipNodesBasedOnFacingDirection():
	# Facing Right:
	if _facing_direction == 1:
		$PlayerSprite.set_flip_h(true)
		$InteractableArea.position = Vector2(10, 34)
		if _package_currently_held != null:
			_package_currently_held.find_node("Sprite").set_flip_h(true)
	# Facing Left:
	elif _facing_direction == -1:
			$PlayerSprite.set_flip_h(false)
			$InteractableArea.position = Vector2(-10, 34)
			if _package_currently_held != null:
				_package_currently_held.find_node("Sprite").set_flip_h(false)
	return


func spriteMovementAnimation():
	if velocity.length() > 0:
		if not _is_fully_moving:
			$PlayerSprite.play("idleToMoving")
			# If on last frame of transitional animation, start full moving animation:
			if $PlayerSprite.frame == $PlayerSprite.frames.get_frame_count("idleToMoving") - 1:
				_is_fully_moving = true
		else:
			$PlayerSprite.play("moving")
	else:
		_is_fully_moving = false
		$PlayerSprite.play("idle")
	return
