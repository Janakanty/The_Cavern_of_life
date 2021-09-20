extends Area2D

var thinks = ["...Mama?", "...Tata?"]
var close = false
onready var player = get_node("../Player")

export (Color,RGB) var mouse_out = Color(1,1,1)
export (Color,RGB) var mouse_over = Color(0.7,0.7,0.7)

func _on_Carpet_body_entered(body):
	if body.is_in_group("Player"): 
		close = true


func _on_Carpet_body_exited(body):
	if body.is_in_group("Player"): 
		close = false
		

func _on_Area2D_mouse_entered():
	set_modulate(mouse_over)


func _on_Area2D_mouse_exited():
	set_modulate(mouse_out)


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("Click") and close == true:
		$Sprite.visible = true
		$Sprite2.visible = false
		$Area2D.visible = false
		player.zoom_camera_animation()
		yield(get_tree().create_timer(0.2), "timeout")
		player.stop_player()
		player.think_panel(thinks)
	

