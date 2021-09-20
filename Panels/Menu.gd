extends Control




func _on_Button_pressed():
	get_tree().change_scene("res://art/Cutscenes/Intro/intro.tscn")
	Save1.reset()


func _on_Button2_pressed():
	get_tree().quit()
