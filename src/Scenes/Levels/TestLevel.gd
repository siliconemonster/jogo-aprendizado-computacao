extends Node2D


# Declare member variables here. Examples:
var health = 3 setget set_health
var score = 0 setget set_score
var threshold_max_score = 0
signal scoreThreshold
signal hpLost

var _texture1 = load("res://assets/Sprites/speaker-icon-sound-icon-white.png")
var _texture2 = load("res://assets/Sprites/sem_som.png")
var _texture3 = load("res://assets/Sprites/som_baixo.png")
var _texture4 = load("res://assets/Sprites/som_medio.png")
var _texturaAtual

var music_on = true
var volume_anterior
var volume

func volume():
	volume_anterior = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Musics"))
	_on_HSlider_value_changed(volume_anterior)
	$HSlider.value = volume_anterior

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
	volume()
	$Esteira.play()
	$Musica_fundo.play()
	$HUD/Control/Health.text = "HEALTH      " +str(health)
	$HUD/Control/Score.text = "SCORE      " +str(score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func gameOver():
	if score > self.read_savegame():
		self.save(score)
	get_tree().change_scene("res://src/Scenes/Levels/GameOverScreen.tscn")

func on_packageLost():
	$Erro.play()
	set_health(health-1)
	if health == 0:
		gameOver()
	$HUD/Control/Health.text = "HEALTH      " +str(health)

func on_packageDelivered():
	$Acerto.play()
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

func read_savegame():
   savegame.open(save_path, File.READ) #open the file
   save_data = savegame.get_var() #get the value
   savegame.close() #close the file
   return save_data["highscore"] #return the value

func save(high_score):  
	savegame.open(save_path, File.WRITE) #open file to write  
	save_data["highscore"] = score #data to save

	savegame.store_var(save_data) #store the data
	savegame.close() # close the file


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musics"), value)
	volume = value
	
	if (value <= -64):
		$HSlider/botao_som.texture_normal = _texture2
		_texturaAtual = _texture2
		
	if (value > -64 and value <= -50):
		$HSlider/botao_som.texture_normal = _texture3
		_texturaAtual = _texture3
		
	if (value > -50 and value <= -35):
		$HSlider/botao_som.texture_normal = _texture4
		_texturaAtual = _texture4
		
	if (value > -35 and value <= -19):
		$HSlider/botao_som.texture_normal = _texture1
		_texturaAtual = _texture1
		
	$HSlider.focus_mode = false


func _on_botao_som_pressed():
	if (music_on):
		$HSlider/botao_som.texture_normal = _texture2
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musics"), -65)
		music_on = false
		
	else:
		$HSlider/botao_som.texture_normal = _texturaAtual
		music_on = true
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musics"), volume)
	

