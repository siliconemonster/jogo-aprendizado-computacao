extends Node2D

signal packageLost

func _on_PackageSlotDetectionArea_body_entered(body: Node) -> void:
	body.queue_free()
	if body.package_held != null:
		emit_signal("packageLost")
	return
