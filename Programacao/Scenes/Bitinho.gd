extends KinematicBody2D

var velocity = Vector2.ZERO


func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		velocity.x = 4
		$AnimationPlayer.play("WalkH")
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		velocity.x = -4
		$AnimationPlayer.play("WalkH")		
	elif velocity.x > 0:
		velocity.x -= 0.5
		if velocity.x == 0.5:
			$AnimationPlayer.play("Stop")
	elif velocity.x < 0:
		velocity.x +=0.5
		if velocity.x == -0.5:
			$AnimationPlayer.play("Stop")
	if Input.is_action_pressed("ui_up"):
		velocity.y =-4
		$AnimationPlayer.play("WalkUp")
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 4
		$AnimationPlayer.play("WalkDown")
	elif velocity.y > 0:
		velocity.y -= 0.5
		if velocity.y == 0.5:
			$AnimationPlayer.play("StopDown")
	elif velocity.y < 0:
		velocity.y +=0.5
		if velocity.y == -0.5:
			$AnimationPlayer.play("StopUp")
		
	move_and_collide(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
