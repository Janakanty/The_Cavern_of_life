extends StaticBody2D

export (Color,RGB) var mouse_out
export (Color,RGB) var mouse_over
var entered = false

var current_dialogue = ['']
var dialog1=false
var dialog2=false


var Covon_start = [
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	
	{'text':'No no no, kogo my tu mamy! Wreszcie się obudziłeś. Pewnie poznałeś już Fionę i Ci powiedziała co i jak?'},
	{'text':'Nasza siedziba znajduje się za tym przejściem do góry, ale Bob Cie nie wpuści.'},
	{'text':'Najpierw musisz wejść do groty. Takie mamy tu zasady. Bez imienia Cię nie wpuścimy.'},
	{'text':'Zrozumiałeś?'},	
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text':'...'},	
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	{'text':'To świetnie! Do zobaczenia potem!'},
]

var Covon_click2 =[
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	{'text': 'Ruchy rychy! Nie marnuj czasu!'},
]


var Covon_click3 =[
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	{'text': 'No no.. Wróciłeś. Nauczyłeś się mówić?'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'name':'hero','text':'Kim ty jesteś? Co to za miejsce? Dlaczego znów widziałem swoich rodziców żywych?'},
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	{'name':'Covon','text':'Mnie się pytasz? Jeżeli Ci się uda, to grota ci odpowie na wszystkie pytania. O ile w niej wcześniej nie umrzesz. '},
	{'name':'Covon','text':'Ja nazywam się Covon. A ty, żeby przejść do naszego miasteczcka, musisz pamiętać swoje imię. Jak ono brzmi?'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'name':'Tobias','text':'...'},
	{'name':'Tobias','text':'Tobias.. Nazywam się Tobias'},
	{'name':'Covon','text':'A więc, witaj Tobiasie! To miejsce nazywamy po prostu jaskinią. A tak dokładniej Jaskinią życia'},
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	{'name':'Covon','text':'Na pewno będę miał tu dla Ciebie jakieś zadanie, ale na razie odpocznij'},
	{'name':'Covon','text':'Do zobaczenia!'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'name':'Tobias','text':'Jaskinia... Życia...'},
	{
	'action':'end_demo'
	},
	
]
	

func _on_Area2D_mouse_entered(): #Zmienia kolor postaci po najechaniu myszką 
	set_modulate(mouse_over)
	pass

func _on_Area2D_mouse_exited(): #Zmienia kolor postaci po odjechaniu myszką 
	set_modulate(mouse_out)
	pass

func what_dialogue_should_be(): #system wyboru, który dialog powinien teraz się wczytać
	if dialog1==false and Save1.all_good==false:
		current_dialogue=Covon_start
		dialog1=true
	elif dialog2==false and Save1.all_good==false:
		current_dialogue=Covon_click2
	elif dialog2==false and Save1.all_good==true:
		current_dialogue=Covon_click3

		
func _on_Area2D_input_event(viewport, event, shape_idx):  #wywołanie dialogu po nacisnieciu w NPC'a
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)
			
	pass # Replace with function body.



func _on_Area2D2_body_entered(body):
	if body.name=="Player" and entered==false and Save1.all_good == true:
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)
		entered = true
