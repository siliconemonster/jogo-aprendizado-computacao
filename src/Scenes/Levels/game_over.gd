extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://src/Scenes/Levels/TitleScreen.tscn")

func _on_Button_button_down():
	$GameOver/MenuSelect.play()
	

func _on_Button_ready():
	$GameOver/Button.grab_focus()


func _on_Button_gui_input(event):
	pass # Replace with function body.
