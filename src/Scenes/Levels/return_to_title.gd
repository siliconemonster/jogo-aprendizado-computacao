extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://src/Scenes/Levels/TitleScreen.tscn")

func _on_Button_button_down():
	$Credits/MenuSelect.play()
	



func _on_Button_ready():
	$Credits/Button.grab_focus()
