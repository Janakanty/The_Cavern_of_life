extends StaticBody2D

export (Color,RGB) var mouse_out = Color(1,1,1)
export (Color,RGB) var mouse_over = Color(0.56,0.56,0.56)
var book = preload("res://book/book11.tscn").instance()
onready var player_pom = get_node("../Player/Camera2D/CanvasLayer")

func _on_Area2D_mouse_entered():
	set_modulate(mouse_over)


func _on_Area2D_mouse_exited():
	set_modulate(mouse_out)


func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		book = preload("res://book/book111.tscn").instance()
		yield(get_tree().create_timer(0.2),"timeout")
		player_pom.add_child(book)
		

