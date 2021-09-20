extends Node2D



func _physics_process(delta):
	if Save1.end_demo == true:
		yield(get_tree().create_timer(1),"timeout")
		get_tree().change_scene("res://Panels/Menu.tscn")


