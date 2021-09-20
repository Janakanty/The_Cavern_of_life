extends Node2D


func _ready():
	start()

func _physics_process(delta): 
	if Save1.end_lv12 == true:
		animate()	
	
func start():
	$YSort/StaticBody2D.visible=true
	$YSort/StaticBody2D2.visible=true
	$YSort/StaticBody2D3.visible=true
	$YSort/StaticBody2D4.visible=true
	$YSort/StaticBody2D5.visible=true
	$YSort/StaticBody2D6.visible=true
	
	
func animate():
	$AnimationPlayer.play("Nowa animacja")
	yield(get_tree().create_timer(4),"timeout")
	#dźwiek chodzenia
	get_tree().change_scene("res://Maps/Dom.tscn")
