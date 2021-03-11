extends Node2D

const PackageSlotResource = preload("res://src/Scenes/Elements/PackageSlot/PackageSlot.tscn")
const PackageResource = preload("res://src/Scenes/Elements/Package/Package.tscn")

var initial_seconds_between_spawns = 2.0

export var seconds_between_spawns := 2.0
export var spawns_packages := true

var _seconds_since_last_spawn = 0.0

func _ready():
	var test_level = get_node("/root/TestLevel")
	test_level.connect("scoreThreshold", self, "on_ScoreThreshold")
	test_level.connect("hpLost", self, "on_hpLost")

func _process(delta: float) -> void:
	_seconds_since_last_spawn += delta
	if _seconds_since_last_spawn > seconds_between_spawns:
		_seconds_since_last_spawn = 0
		spawn_package_slot()
#Change the speed of spawner based on score
func on_ScoreThreshold():
	if seconds_between_spawns > 1.2:
		self.seconds_between_spawns = self.seconds_between_spawns - 0.1
#Resets the speed of the package spawn based on the time-out event
func on_hpLost():
	self.seconds_between_spawns = initial_seconds_between_spawns
# Spawns a PackageSlot with a Package in it: 
func spawn_package_slot():
	var package_slot_instance = PackageSlotResource.instance()
	
	package_slot_instance.position = self.position
	
	package_slot_instance.movement_speed = 350.0
	package_slot_instance.movement_direction = Vector2.DOWN

	if spawns_packages:
		var package_instance = PackageResource.instance()
		var color = randi()%10+1
		if color <= 5:
			package_instance.set_package_color("Blue")
		elif color >5:
			package_instance.set_package_color("Green")
		package_slot_instance.package_held = package_instance
		package_slot_instance.add_child(package_instance)
	
	self.get_parent().add_child(package_slot_instance)
