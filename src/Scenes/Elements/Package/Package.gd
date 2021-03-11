extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var package_color = "Green" setget set_package_color
# Called when the node enters the scene tree for the first time.
func _ready():
	#$GreenPackage.visible = false
	#$BluePackage.visible = false
	pass # Replace with function body.

func set_package_color(color):
	package_color = color
	if package_color == "Green":
		$GreenPackage.visible = true
		$BluePackage.visible = false
	elif package_color == "Blue":
		$BluePackage.visible = true
		$GreenPackage.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
