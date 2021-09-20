extends StaticBody2D

var current_dialogue
var flaga = false
var flaga2 = false
var drzewo_rozmowa = [
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text':'Czy to?... '},
	{'text':'Nie ... to nie możliwe. Wygląda jak z opisu z książki... '},
	{'text':'Drzewo polaru to musi być to! '},
	{
		'background': ""
	},
	{'text':'*Słychać dziwny dźwięk. Czyjeś słowa* '},
	{'text':'*Weź tę gałąskę... Niech Ci służy w walce... A co ważniejsze...* '},
	{'text':'*Niech Ci służy w Twoich wyborach. Jeżeli masz odnaleźć drogę do światła ...* '},
	{'text':'*musisz z niej korzystać by wypełnić przeznaczenie* '},
	{'text':'[klawisze "1" i "2" aby przełączać się między broniami] '},
	{'action': "lv_up"}
]

var wujek = [
	{'text':'*głos dobiega z ciemności...*'},
	{
		'background': "res://art/wujek.png"
	},
	{'text':'Znalazłem Cię!'},
	{'text':'Chyba mnie poznajesz'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text': 'wujek... '},
	{
		'background': "res://art/wujek.png"
	},
	{'text':'Chodź. Musimy uciekać. Potwory wylały się na całe okolice. Nie ma już tu dla nas życia'},
	{'text':'Mój brat już dawno powinien się stąd wynosić. Na południe stąd mam kawałek ziemi. Chodź mały'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text': '... '},
	{
		'background': "res://art/wujek.png"
	},
	{'text':'Szybko Gówniarzu! Co się gapisz? Chyba nie chcesz zostać tu i czekać na śmierć?!'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text': 'Pamiętam cię... Nie pójdę z Tobą. Pamiętam całe życie. Pamiętam dzień jak od Ciebie uciekłem.'},
	{'text': 'Pamiętam, i nie wiem dalczego przeżywam to jeszcze raz, ale zostanę tu i choćbym miał umrzeć, nie pójdę z Tobą'},
	{
		'background': "res://art/wujek.png"
	},
	{'text':'Idę przodem. Jak będziesz chciał do mnie dołączyć będziesz musiał mnie gonić. Psia krew. '},
	{'text':'Tylko masz nikomu nie mówić, że nie zaproponowałem pomocy! A zresztą. I tak nie przeżyjesz.'},
	{'action':'end_lv14'}
]

func wujek():
	current_dialogue = wujek
	var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
	var camera = get_node("../Player/Camera2D/CanvasLayer")
	dialog.dialog_script=current_dialogue
	camera.add_child(dialog)	
		
func what_dialogue_should_be():
	current_dialogue = drzewo_rozmowa


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and flaga == false:
		flaga = true
		Save1.weapon2 = true
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)
