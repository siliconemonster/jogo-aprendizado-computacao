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
	if not savegame.file_exists(save_path):
		create_save()
	$Esteira.play()
	$Musica_fundo.play()
	$HUD/Control/Health.text = "HEALTH      " +str(health)
	$HUD/Control/Score.text = "SCORE      " +str(score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func gameOver():
	self.save(score)
	get_tree().change_scene("res://src/Scenes/Levels/GameOverScreen.tscn")

func on_packageLost():
	set_health(health-1)
	if health == 0:
		gameOver()
	$HUD/Control/Health.text = "HEALTH      " +str(health)

func on_packageDelivered():
	set_score(score +5)
	$HUD/Control/Score.text = "SCORE      " +str(score)
	pass # Replace with function body.

func _on_BluePackageDespawner_packageDelivered():
	self.on_packageDelivered()
func _on_BluePackageDespawner_packageLost():
	self.on_packageLost()
	

func _on_GreenPackageSlotDespawner_packageDelivered():
	self.on_packageDelivered()
func _on_GreenPackageSlotDespawner_packageLost():
	self.on_packageLost()

#Sessão do highscore
var savegame = File.new() #file
var save_path = "user://savegame.save" #place of the file
var save_data = {"highscore": 0} #variable to store data

func create_save():
   savegame.open(save_path, File.WRITE)
   savegame.store_var(save_data)
   savegame.close()

func save(high_score):    
   save_data["highscore"] = score #data to save
   savegame.open(save_path, File.WRITE) #open file to write
   savegame.store_var(save_data) #store the data
   savegame.close() # close the file
