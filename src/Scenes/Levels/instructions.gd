extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://src/Scenes/Levels/TitleScreen.tscn")

func _on_Button_button_down():
	$Instructions/MenuSelect.play()
	

func _on_Button_ready():
	$Instructions/Button.grab_focus()


func _on_Button_gui_input(event):
	pass # Replace with function body.
