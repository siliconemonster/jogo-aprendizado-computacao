extends Node2D


# Declare member variables here. Examples:
var health = 3 setget set_health
var score = 0 setget set_score
var threshold_max_score = 0
signal scoreThreshold
signal hpLost

func set_health(value):
	health = value
	emit_signal("hpLost")
	
func set_score(value):
	score = value
	if (score-threshold_max_score)%5 == 0:
		emit_signal("scoreThreshold")
		threshold_max_score = score


# Called when the node enters the scene tree for the first time.
func _ready():
	$Esteira.play()
	$Musica_fundo.play()
	$HUD/Control/Health.text = "HEALTH      " +str(health)
	$HUD/Control/Score.text = "SCORE      " +str(score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func gameOver():
	get_tree().change_scene("res://src/Scenes/Levels/GameOverScreen.tscn")

func on_packageLost():
	set_health(health-1)
	if health == 0:
		gameOver()
	$HUD/Control/Health.text = "HEALTH      " +str(health)

func _on_PackageSlotDespawner_packageDelivered():
	set_score(score +5)
	$HUD/Control/Score.text = "SCORE      " +str(score)
	pass # Replace with function body.
