extends Node2D

func _on_PackageSlotDetectionArea_body_entered(body: Node) -> void:
	body.queue_free()
	return
