extends Control

var scene_path_to_load
var music_on = true
var volume

var _texture1 = load("res://assets/Sprites/speaker-icon-sound-icon-white.png")
var _texture2 = load("res://assets/Sprites/sem_som.png")
var _texture3 = load("res://assets/Sprites/som_baixo.png")
var _texture4 = load("res://assets/Sprites/som_medio.png")
var _texturaAtual

func _ready():
	$Musica_fundo.play()
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()
	
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_button_pressed", [button.scene_to_load])
		
func _on_button_pressed(scene_to_load):
	$Menu/MenuSelect.play()
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)


func _on_CreditsButton_gui_input(event):
	if event.is_action_pressed("ui_up"):
		$Menu/MenuMove.play()

func _on_InstructionsButton_gui_input(event):
	if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
		$Menu/MenuMove.play()

func _on_NewGameButton_gui_input(event):
	if event.is_action_pressed("ui_down"):
		$Menu/MenuMove.play()


func _on_CreditsButton_mouse_entered():
	$Menu/MenuMove.play()
	$Menu/CenterRow/Buttons/CreditsButton.grab_focus()

func _on_InstructionsButton_mouse_entered():
	$Menu/MenuMove.play()
	$Menu/CenterRow/Buttons/InstructionsButton.grab_focus()

func _on_NewGameButton_mouse_entered():
	$Menu/MenuMove.play()
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()


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
	
func _on_botao_som_pressed():
	
	if (music_on):
		$HSlider/botao_som.texture_normal = _texture2
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musics"), -65)
		music_on = false
		
	else:
		$HSlider/botao_som.texture_normal = _texturaAtual
		music_on = true
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musics"), volume)
	

