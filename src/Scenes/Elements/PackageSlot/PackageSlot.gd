extends KinematicBody2D

var package_held = null

var movement_direction = Vector2.DOWN
var movement_speed = 0.0

func _on_ConveyorBeltTrackDetector_area_entered(area: Area2D) -> void:
	movement_direction = area.get_parent().conveyor_belt_direction
	movement_speed = area.get_parent().conveyor_belt_speed

func _ready() -> void:
	$PackageSpriteForVisualReference.queue_free()

func _physics_process(delta: float) -> void:
	move_and_slide(movement_direction * movement_speed)
