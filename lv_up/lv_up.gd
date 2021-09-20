extends Control

export (Color,RGB) var mouse_out = Color(1,1,1)
export (Color,RGB) var mouse_over = Color(0.86,0.86,0.86)

var atak = "Wbierz aby zwiększyć obrażenia!"
var zdrowie = "Wybierz aby zwiększyć zdrowie!"
var szybkosc = "Wybierz aby zwiększyć szybkość i czas biegania!"
var nic = "Wybierz swój awans!"

onready var label = get_node("ColorRect/Label")

func _ready():
	$Node.play("Nowa animacja")


func _on_TextureButton_mouse_entered():
	$TextureButton.set_modulate(mouse_over)
	label.text = atak


func _on_TextureButton_mouse_exited():
	$TextureButton.set_modulate(mouse_out)
	label.text = nic


func _on_TextureButton2_mouse_entered():
	$TextureButton2.set_modulate(mouse_over)
	label.text = zdrowie


func _on_TextureButton2_mouse_exited():
	$TextureButton2.set_modulate(mouse_out)
	label.text = nic


func _on_TextureButton3_mouse_entered():
	$TextureButton3.set_modulate(mouse_over)
	label.text = szybkosc


func _on_TextureButton3_mouse_exited():
	$TextureButton3.set_modulate(mouse_out)
	label.text = nic


func _on_TextureButton_pressed():
	Save1.add_damage += 2
	Save1.current_hp = Save1.hp
	queue_free()
	Save1.fight = true


func _on_TextureButton2_pressed():
	Save1.hp += 5
	Save1.current_hp = Save1.hp
	queue_free()
	Save1.fight = true


func _on_TextureButton3_pressed():
	Save1.add_speed += 20
	Save1.stamina +=200
	Save1.current_hp = Save1.hp
	queue_free()
	Save1.fight = true


