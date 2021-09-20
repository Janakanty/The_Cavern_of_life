extends Node

var auxiliary_dialog = false

var add_damage = 0
var add_speed = 0
var atak = 10
var hp = 20
var current_hp = 20
var stamina = 100
var current_stamina = 100
export var speed = 0 
var max_speed = 120
var acceleration = 1299
var selected_skill = "NoWeapon"
var melee = false
var damage
var rate_of_fire = 0.6

var weapon1 = true
var weapon2 = false

#zadania demo
var quest1 = false #zabicie pluskwa
var end_lv12 = false #koniec dialogu i przejsięcie do domu
var end_lv13_fire = false
var end_lv13 = false
var odp1 = false
var odp2 = false
var odp3 = false
var all_good = false
var lv_up = false
var fight = false
var to_end = 0
var end_14 = false
var end_demo = false


func reset():
	var auxiliary_dialog = false

	var add_damage = 0
	var add_speed = 0
	var atak = 10
	var hp = 20
	var current_hp = 20
	var stamina = 100
	var current_stamina = 100
	var max_speed = 120
	var acceleration = 1299
	var selected_skill = "NoWeapon"
	var melee = false
	var damage
	var rate_of_fire = 0.6

	var weapon1 = true
	var weapon2 = false

	#zadania demo
	var quest1 = false #zabicie pluskwa
	var end_lv12 = false #koniec dialogu i przejsięcie do domu
	var end_lv13_fire = false
	var end_lv13 = false
	var odp1 = false
	var odp2 = false
	var odp3 = false
	var all_good = false
	var lv_up = false
	var fight = false
	var to_end = 0
	var end_14 = false
	var end_demo = false
