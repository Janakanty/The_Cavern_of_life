extends StaticBody2D

export (Color,RGB) var mouse_out = Color(1,1,1)
export (Color,RGB) var mouse_over = Color(0.86,0.86,0.86)

onready var map = get_node("/root/Map")

var current_dialogue = ['']
var dialog1=false
var dialog2=false
var dialog3=false


var entered = false

var Covon_start = [
	{
		'background': "res://art/Sprites_NPC/tata_profil.png"
	},
	
	{'text':'Długo szedłeś. Mógłbyś chociaż raz przyjść na czas!'},
	{'text':'Tak czy inaczej dobrze, że jesteś. Synu, dzisiaj przejdziesz swój chrzest bojowy'},
	{'text':'Postarałem się o jakiegoś pluskwa. Masz go zabić gołymi rękami'},
	{'text':'Zrozumiałeś? '},	
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text':'Plu...'},	
	{'text':'...skw'},
	{
		'background': "res://art/Sprites_NPC/tata_profil.png"
	},
	{'text':'Byłem młodszy jak sobie radziłem z takim chrustem jak to, ale uważaj aby Cię nie ugryzł, bo rana od jego zębów do najprzyjemniejszych nie należy'},
	{'text':'A teraz ruszaj. Sporo się naprawcowałem abyś miał takiego łatwego przeciwnika na początek'},
]

var Covon_click2 =[
	{
		'background': "res://art/Sprites_NPC/tata_profil.png"
	},
	{'text': 'Jeszcze go nie zabiłeś? Nie trać czasu!'},
]


var Covon_click3 =[
	{
		'fade-in': 2
	},
	{
		'background': "res://art/Sprites_NPC/tata_profil.png"
	},
	{
		'text': 'Udało się! Haahahaaha! Zuch chłopak!'
	},
	{
		'question': 'I jak było?',
		'options': [
			{ 'label': 'Tak...', 'value': '#1da0f7'},
			{ 'label': 'Niee..', 'value': '#f7411d'}
		],
		'variable': 'fav_color'
	},
	{
		'text': ' [fav_color]? Co to znaczy?'
	},
	{
		'text': 'Z resztą. W końcu możemy nadać Ci imię. Ale może przed tym w końcu nauczyłbyś się mówić?'
	},
	{	
		'text': 'Idź do domu i nie wychodź póki nie przeczytasz chociaż jednej z książek mamy!', 	
	},
		{
		'action': 'end_lv12'
	}
	
]

var tata_die =[
	{
		'background': "res://art/Sprites_NPC/tata_profil.png"
	},
	{'text': 'Gdzie mama?! '},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text': 'Mówiła, że dobiegnie do nas. Kazała mi uciekać... Tato? '},
	{
		'background': "res://art/Sprites_NPC/tata_profil.png"
	},
	{'text': 'Psia krew! I pozwoliłeś jej na to?!'},
	{'text': '...Niech będzie. Idę po nią'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text': 'Tato. A co z moim imieniem? Muszę je sobie przypomnieć '},
	{
		'background': "res://art/Sprites_NPC/tata_profil.png"
	},
	{'text': 'Przypomnieć? Teraz nie ma na to czasu. '},
	{'text': 'Ale niech będzie... Tobias.  '},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text': 'Tobias? '},
	{'text': 'Już pamiętam. Jak jeden z królów '},
	{
		'background': "res://art/Sprites_NPC/tata_profil.png"
	},
	{'text': 'A teraz, Tobiasie. Idź za pochodniami, nie oddalaj się od światła. Później podróżuj dalej na zachód  '},
	{'text': 'We wsi Obrze znajdziesz mojego brata. Tam będziez na nas czekał! Idź! Nie marnuj czasu!'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text': 'Zrozumiałem... Żegnaj tato...Miło Cię było znów zobaczyć '},
	{
		'background': "res://art/Sprites_NPC/tata_profil.png"
	},
	{'text': 'Nie bredź. Widzimy się jutro.  '},
]

		
func _on_Area2D_input_event(viewport, event, shape_idx):  #wywołanie dialogu po nacisnieciu w NPC'a
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)

func what_dialogue_should_be(): #system wyboru, który dialog powinien teraz się wczytać
	if Save1.quest1 == false:
		if dialog1==false:
			current_dialogue=Covon_start
			dialog1=true
		elif dialog2==false:
			current_dialogue=Covon_click2 
	elif Save1.quest1 == true and Save1.end_lv13 == false: 
		if dialog3 == false:
			current_dialogue= Covon_click3
	elif Save1.quest1 == true and Save1.end_lv13 == true:
		current_dialogue = tata_die
		
			
func level_end():
	Save1.end_lv12 = true

func _on_Area2D_mouse_entered(): #Zmienia kolor postaci po najechaniu myszką 
	set_modulate(mouse_over)
	pass

func _on_Area2D_mouse_exited(): #Zmienia kolor postaci po odjechaniu myszką 
	set_modulate(mouse_out)
	pass


func _on_Area2D2_body_entered(body):
	if body.name=="Player" and entered==false:
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)
		entered = true
