extends Node2D

signal packageDelivered
signal packageLost

func _on_PackageSlotDetectionArea_body_entered(body: Node) -> void:
	body.queue_free()
	if body.package_held != null and body.package_held.color == "Blue":
		emit_signal("packageDelivered")
	elif body.package_held != null and body.package_held.color == "Green":
		emit_signal("packageLost")
	return
