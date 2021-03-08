extends Node2D

const PackageSlotResource = preload("res://src/Scenes/Elements/PackageSlot/PackageSlot.tscn")
const PackageResource = preload("res://src/Scenes/Elements/Package/Package.tscn")

export var seconds_between_spawns := 1.5
export var spawns_packages := true

var _seconds_since_last_spawn = 0.0

func _process(delta: float) -> void:
	_seconds_since_last_spawn += delta
	if _seconds_since_last_spawn > seconds_between_spawns:
		_seconds_since_last_spawn = 0
		spawn_package_slot()
	
# Spawns a PackageSlot with a Package in it: 
func spawn_package_slot():
	var package_slot_instance = PackageSlotResource.instance()
	
	package_slot_instance.position = self.position
	
	package_slot_instance.movement_speed = 350.0
	package_slot_instance.movement_direction = Vector2.DOWN

	if spawns_packages:
		var package_instance = PackageResource.instance()
		package_slot_instance.package_held = package_instance
		package_slot_instance.add_child(package_instance)
	
	self.get_parent().add_child(package_slot_instance)
