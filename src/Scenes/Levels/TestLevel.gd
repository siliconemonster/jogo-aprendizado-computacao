extends Node2D


# Declare member variables here. Examples:
var health = 3 setget set_health
var score = 0 setget set_score

func set_health(value):
	health = value
	
func set_score(value):
	score = value


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Health.text = "HEALTH      " +str(health)
	$Control/Score.text = "SCORE      " +str(score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func gameOver():
	get_tree().change_scene("res://src/Scenes/Buttons/CreditsButton.tscn")

func _on_PackageSlotDespawner_packageLost():
	set_health(health-1)
	if health == 0:
		gameOver()
	$Control/Health.text = "HEALTH      " +str(health)



func _on_PackageSlotDespawner2_packageDelivered():
	set_score(score +5)
	$Control/Score.text = "SCORE      " +str(score)
	
	pass # Replace with function body.
