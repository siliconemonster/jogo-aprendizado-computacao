extends Node2D

signal packageDelivered

func _on_PackageSlotDetectionArea_body_entered(body: Node) -> void:
	body.queue_free()
	if body.package_held != null:
		emit_signal("packageDelivered")
	return
