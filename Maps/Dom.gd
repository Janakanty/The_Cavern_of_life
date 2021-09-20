extends Node2D

func _ready():
	#animate1()
	pass

func _physics_process(delta):
	if Save1.end_lv13_fire == true: 
		animate1()
	if Save1.end_lv13 == true:
		animate2()

func animate1():
	#$CanvasModulate.color = Color(1,0.11,0.11)
	var tween = get_node("Tween")
	tween.interpolate_property($CanvasModulate, "color", Color(1,0.11,0.11), Color(1,1,1), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func animate2():
	get_tree().change_scene("res://Maps/lv14.tscn")
