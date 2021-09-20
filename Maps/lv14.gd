extends Node2D

var flaga0 = false
var flaga1 = false
var flaga2 = false
var flaga3 = false
var flaga4 = false


func _ready():
	$YSort/StaticBody2D2.visible = true
	$YSort/StaticBody2D3.visible = true


func _physics_process(delta):
	if Save1.to_end == 2 and flaga0 == false:
		flaga0 = true
		get_node("YSort/Node2D").wujek()
	if Save1.fight == true:
		Save1.fight = false
		$YSort/blip.visible = true
		$YSort/blip2.visible = true	
	print(Save1.to_end)
	if Save1.end_14 == true:
		yield(get_tree().create_timer(2),"timeout")
		get_tree().change_scene("res://Map.tscn")


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and  flaga1 == false: 
		$YSort/StaticBody2D2.queue_free()
		$YSort/StaticBody2D5.visible = true
		flaga1= true


func _on_Area2D2_body_entered(body) :
	if body.is_in_group("Player") and flaga2 == false: 
		$YSort/StaticBody2D3.queue_free()
		$YSort/StaticBody2D6.visible = true
		flaga2 = true


func _on_Area2D3_body_entered(body) :
	if body.is_in_group("Player") and flaga3 == false : 
		$YSort/StaticBody2D5.queue_free()
		$YSort/StaticBody2D7.visible = true
		flaga3 = true


func _on_Area2D4_body_entered(body):
	if body.is_in_group("Player") and flaga4 == false : 
		$YSort/StaticBody2D6.queue_free()
		$YSort/StaticBody2D8.visible = true
		flaga4 = true
