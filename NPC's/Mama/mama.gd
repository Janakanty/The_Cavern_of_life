extends StaticBody2D

export (Color,RGB) var mouse_out = Color(1,1,1)
export (Color,RGB) var mouse_over = Color(0.86,0.86,0.86)

onready var srodek = get_node("AnimatedSprite/Sprite").global_position
onready var player = get_parent().get_node("Player")
onready var dir_eye = srodek.direction_to(player.global_position)*1

onready var map = get_node("/root/Map")
var entered = false

var current_dialogue = ['']
var dialog1=false
var dialog2=false
var dialog3=false
var dialog4=false



var mama_start = [
	{
		'background': "res://art/Sprites_NPC/mama_profil.png"
	},
	
	{'text':'Syneczku. Tata Cię woła. Nie stój tak i nie każ mu czekać! '},
]

var mama_click2 =[
	{
		'background': "res://art/Sprites_NPC/mama_profil.png"
	},
	{'text': 'Czekałam na Ciebie kochanie!'},
	{'text': 'Wkótce nadamy Ci imię. Oczywicie jest już wybrane, ale zanim je usłyszysz tata kazał Ci się trochę pouczyć'},
	{'text': 'Niestety masz duże problemy z odpowiadaniem na pytania'},
	{'text': 'Poczytaj sobię te książki a ja Cię potem z nich przepytam'},
]

var mama_przepytywanie =[
	{
		'background': "res://art/Sprites_NPC/mama_profil.png"
	},
	{'text': 'Przeczytałeś? Sprawdzę czy nie oszukiwałeś'},
	{
		'question': 'Jak nazywa się era, w której teraz żyjemy?',
		'options': [
			{ 'label': 'Obrony', 'value': 'Obrony'},
			{ 'label': 'Ataku', 'value': 'Ataku', },
			{ 'label': 'Królów', 'value': 'Królów'}
		],
		'variable': 'odp1'
	},
	{
		'question': 'Jak nazywa się pierwszy potwór, którego zabił Jasio?',
		'options': [
			{ 'label': 'Kordok', 'value': 'Kordok'},
			{ 'label': 'Nieumarły', 'value': 'Nieumarły'},
			{ 'label': 'Pioskol', 'value': 'Pioskol',}
		],
		'variable': 'odp2' 
	},
	{
		'question': 'Jak nazywa się roślina lecznicza rosnąca pod mchem dębu?',
		'options': [
			{ 'label': 'Liść Krali', 'value': 'Liść Krali',},
			{ 'label': 'Krzew Marty', 'value': 'Krzew Marty'},
			{ 'label': 'Liść Lortera', 'value': 'Liść Loreta'}
		],
		'variable': 'odp3' 
	},

]

var mama_przepytywanie2 =[
	{
		'background': "res://art/Sprites_NPC/mama_profil.png"
	},
	{'text': 'Niestety źle synusiu. Sprawdźmy jeszcze raz:'},
	{
		'question': 'Jak nazywa się era, w której teraz żyjemy?',
		'options': [
			{ 'label': 'Obrony', 'value': 'Obrony'},
			{ 'label': 'Ataku', 'value': 'Ataku', },
			{ 'label': 'Królów', 'value': 'Królów'}
		],
		'variable': 'odp1'
	},
	{
		'question': 'Jak nazywa się pierwszy potwór, którego zabił Jasio?',
		'options': [
			{ 'label': 'Kordok', 'value': 'Kordok'},
			{ 'label': 'Nieumarły', 'value': 'Nieumarły'},
			{ 'label': 'Pioskol', 'value': 'Pioskol',}
		],
		'variable': 'odp2' 
	},
	{
		'question': 'Jak nazywa się roślina lecznicza rosnąca pod mchem dębu?',
		'options': [
			{ 'label': 'Liść Krali', 'value': 'Liść Krali',},
			{ 'label': 'Krzew Marty', 'value': 'Krzew Marty'},
			{ 'label': 'Liść Lortera', 'value': 'Liść Loreta'}
		],
		'variable': 'odp3' 
	},
]

var the_last =[
	{
		'background': "res://art/Sprites_NPC/mama_profil.png"
	},
	
	{'text':'Brawo! Myślę, że starczy '},
	{'text':'Powiem tacie, że już jesteś gotowy '},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text':'Mamo? '},
	{
		'background': "res://art/Sprites_NPC/mama_profil.png"
	},
	{'text':'Tak Kochanie? '},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text':'Nie rozumiem co się dzieje. Przecież... wy nie żyj... '},
	{
		'background': "res://art/Sprites_NPC/mama_profil_bad.png"
	},
	{'text':'Co to było? '},
	{
		'action': 'fire'
	},
	{'text':'Synku! W tej chwili uciekaj do taty! Jest on za lasem!  '},
	{'text':'Potwory atakują! Dobiegnę do was! '},
	{
		'action': 'end_lv_13'
	}
]


func answeres():
	if Save1.odp1 == true and Save1.odp2 == true and Save1.odp3==true:
		Save1.all_good = true

#global_position.direction_to(target)
func _physics_process(delta):
	srodek = get_node("AnimatedSprite").global_position
	dir_eye = srodek.direction_to(player.global_position)*2
	get_node("AnimatedSprite/Sprite").global_position = srodek+dir_eye
	answeres()
	if Save1.end_lv13 == true:
		pass
	
func _ready():
	$AnimationPlayer.play("fly")
	

func actuaization():
	srodek = get_node("AnimatedSprite/Sprite").global_position
	
func what_dialogue_should_be(): #system wyboru, który dialog powinien teraz się wczytać
	if Save1.quest1 == false:
		if dialog1==false:
			current_dialogue=mama_start
	else:
		if dialog2 == false:
			current_dialogue=mama_click2
			dialog2 = true
		elif dialog3 == false and Save1.all_good ==false:
			current_dialogue=mama_przepytywanie
			dialog3 = true
		elif dialog4 == false and Save1.all_good == false:
			current_dialogue = mama_przepytywanie2
		elif dialog4 == false and Save1.all_good == true:
			current_dialogue = the_last
			


func _on_Area2D2_mouse_entered():
	set_modulate(mouse_over)


func _on_Area2D2_mouse_exited():
	set_modulate(mouse_out)


func _on_Area2D2_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)


func _on_Area2D_body_entered(body):
	if body.name=="Player" and entered==false:
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)
		entered = true
		
