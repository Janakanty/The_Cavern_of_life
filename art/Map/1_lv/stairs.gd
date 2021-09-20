extends StaticBody2D

export (Color,RGB) var mouse_out = Color(1,1,1)
export (Color,RGB) var mouse_over = Color(0.86,0.86,0.86)

var in_range = false





func _on_Area2D2_body_entered(body):
	if body.name == "player" || body.name == "Player":
		in_range = true



func _on_Area2D2_body_exited(body):
	if body.name == "player" || body.name == "Player":
		in_range = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	if in_range == true:
		if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
			get_tree().change_scene("res://Maps/lv12.tscn")


func _on_Area2D_mouse_entered():
	set_modulate(mouse_over)


func _on_Area2D_mouse_exited():
	set_modulate(mouse_out)
