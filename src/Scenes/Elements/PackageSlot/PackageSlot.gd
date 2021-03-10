extends KinematicBody2D

var package_held = null

var movement_direction = Vector2.DOWN
var movement_speed = 0.0
signal packageLost

func _on_ConveyorBeltTrackDetector_area_entered(area: Area2D) -> void:
	movement_direction = area.get_parent().conveyor_belt_direction
	movement_speed = area.get_parent().conveyor_belt_speed

func _ready() -> void:
	$PackageSpriteForVisualReference.queue_free()
	var test_level = get_node("/root/TestLevel")
	connect("packageLost", test_level, "on_packageLost")

func _physics_process(delta: float) -> void:
	move_and_slide(movement_direction * movement_speed)

func _on_PackageSlotDestructionDetector_body_entered(body: Node) -> void:
	#Lógica de fazer o jogador perder vida ou gameover ao pacote ser destruído ao cair em cima de outro em caso de fila cheia.
	#Feito
	emit_signal("packageLost")
	#TODO
	#Animação de pacote sendo destruido.
	self.queue_free()
