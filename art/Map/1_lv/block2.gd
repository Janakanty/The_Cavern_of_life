extends StaticBody2D




func _ready():
	pass # Replace with function body.




func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		var to = get_node("/root/Map/YSort/block_long")
		to.visible = true
		get_node("/root/Map/YSort/Player").max_speed = 140
		
