extends Node2D

signal packageDelivered
signal packageLost

func _on_PackageSlotDetectionArea_body_entered(body: Node) -> void:
	body.queue_free()
	if body.package_held != null and body.package_held.package_color == "Blue":
		emit_signal("packageDelivered")
	elif body.package_held != null and body.package_held.package_color == "Green":
		emit_signal("packageLost")
	return
