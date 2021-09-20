extends StaticBody2D

func _on_Towhite_body_entered(body): 
	var p = get_node("/root/Map/YSort/Player")
	if body.is_in_group("Player"):
		if p.modulate.r < 0.6:
			p.modulate.r = modulate.r + 0.44
			p.modulate.g = modulate.g + 0.44
			p.modulate.b = modulate.b + 0.44
			yield(get_tree().create_timer(1), "timeout")


func _on_Toblack_body_entered(body):
	var p = get_node("/root/Map/YSort/Player")
	if body.is_in_group("Player"):
		if p.modulate.r > 0.6:
			p.modulate.r = modulate.r - 0.44
			p.modulate.g = modulate.g - 0.44
			p.modulate.b = modulate.b - 0.44
			yield(get_tree().create_timer(1), "timeout")

