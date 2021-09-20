extends KinematicBody2D



#Attack
var selected_skill = "NoWeapon"
var can_fire = true
var shooting = false
var melee = false
var damage
var rate_of_fire = 0.8


#Main propertie
var hp = Save1.hp #20
var max_speed = Save1.max_speed #120
var stamina = Save1.stamina #100


#For the hero to work
onready var hp_bar = get_node("Camera2D/CanvasLayer/Hp/TextureRect/ProgressBar")
onready var stamina_bar = get_node("Camera2D/CanvasLayer/Stamina/TextureRect/TextureProgress")
export var speed = 0  # How fast the player will move (pixels/sec).
var acceleration = 1299
var move_direction = 1 
var fire_direction = 0
var moving = false
var destination = Vector2()
var movement = Vector2()

#Think system
var thinks_from
var think = 0
var think_panel = false

#Animation
var animation 
var anim_direction = "S"
var anim_mode = "Idle_S"
var weapon = 1


### ### ### ### click function ### ### ### ### ###	

func _unhandled_input(event): 
	if event.is_action_pressed("Click"):
		moving = true
		$AudioStreamPlayer.play()
		destination = get_global_mouse_position()
	if (event.is_action_pressed("ui_select")):
		moving = false
		$AudioStreamPlayer.stop()

func click(): 
	if Input.is_action_pressed("Click"):
		if position.distance_to(destination) > 5 and Save1.auxiliary_dialog==false :
			moving = true
			destination = get_global_mouse_position()   #testowanie co lepsze 
### ### ### ### Main function ### ### ### ### ###	

func _input(event):
	think_panel_next()
	exit()
	
func _ready():
	bars_start()
		
func _process(delta):
	AnimationLoop()
	SkillLoop() 
	click() 
	
func _physics_process(delta):
	lv_up()
	MovementLoop(delta)
	choose_weapons()
	#jump(delta)
	run(delta)
	stamina_regeneration()
	#think_panel_next()
	
### ### ### ### Basic function ### ### ### ### ###	
	
func exit():
	if Input.is_action_just_pressed("esc"):
		$Camera2D/CanvasLayer/Exit.visible = true
		
func MovementLoop(delta): #function to walk hero by click
	if moving == false:       
		speed = 0
		$AudioStreamPlayer.stop()
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
	movement = position.direction_to(destination) * speed
	move_direction = rad2deg(destination.angle_to_point(position))
	if position.distance_to(destination) > 5:
		movement = move_and_slide(movement)
	else:
		moving = false
		$AudioStreamPlayer.stop()

func SkillLoop():
	if Input.is_action_just_pressed("Shoot") and can_fire == true:
		can_fire = false
		shooting = true
		speed = 0
		moving = false
		fire_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())
		match DataImport.skill_data[selected_skill].SkillType:
			"MeleeAttack1":
				melee = true
				damage = int(DataImport.skill_data[selected_skill].SkillDamage) + int(Save1.add_damage)
			"MeleeAttack2":
				melee = true
				damage = int(DataImport.skill_data[selected_skill].SkillDamage) + int(Save1.add_damage)
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
		shooting = false
		melee = false
		speed = 140
		
		
func AnimationLoop():  #function for setting the appropriate animation of the player
	if shooting == true:
		stop_player()
		anim_mode = "Attack"
		if fire_direction <= 15 and fire_direction >= -15:
			anim_direction = "E"
		elif fire_direction <= 60 and fire_direction >= 15:
			anim_direction = "SE"
		elif fire_direction <= 120 and fire_direction >= 60:
			anim_direction = "S"
		elif fire_direction <= 165 and fire_direction >= 120:
			anim_direction = "SW"
		elif fire_direction >= -60 and fire_direction<= -15:
			anim_direction = "NE" 
		elif fire_direction >= -120 and fire_direction <= -60:
			anim_direction = "N"
		elif fire_direction >= -165 and fire_direction <= -120:
			anim_direction = "NW"
		elif fire_direction <= -165 or fire_direction >= 165:
			anim_direction = "W"
			
	else:
		if move_direction <= 15 and move_direction >= -15:
			anim_direction = "E"
		elif move_direction <= 60 and move_direction >= 15:
			anim_direction = "SE"
		elif move_direction <= 120 and move_direction >= 60:
			anim_direction = "S"
		elif move_direction <= 165 and move_direction >= 120:
			anim_direction = "SW"
		elif move_direction >= -60 and move_direction <= -15:
			anim_direction = "NE" 
		elif move_direction >= -120 and move_direction <= -60:
			anim_direction = "N"
		elif move_direction >= -165 and move_direction <= -120:
			anim_direction = "NW"
		elif move_direction <= -165 or move_direction >= 165:
			anim_direction = "W"
			
		if moving == true:
			anim_mode = "Walk"
		else: 
			anim_mode = "Idle"
		
	if weapon == 1:
		animation = anim_mode + "_" + anim_direction
		
	elif weapon == 2:
		animation = "Sword_" + anim_mode + "_" + anim_direction
	
	get_node("AnimationPlayer").play(animation)
	
### ### ### ### Other functions ### ### ### ### ###	


func choose_weapons():
	if Input.is_action_just_pressed("one"):
		if Save1.weapon1 == true:
			weapon=1
			selected_skill="NoWeapon"
		else: 
			pass
	if Input.is_action_just_pressed("two"):
		if Save1.weapon2 == true:
			selected_skill="BasicWeapon"
			weapon=2
		else: 
			pass

func run(delta):
	if Input.is_action_pressed("run") and Save1.auxiliary_dialog==false and moving == true and stamina_bar.value > 2: 
		max_speed = 220 + Save1.add_speed
		stamina -= 1
		stamina_bar.value -=1
	else:
		max_speed = 120
		
func stamina_regeneration():
	if !Input.is_action_pressed("run"):
		max_speed = 120
		stamina += 1
		stamina_bar.value +=1	
		
func jump(delta):
	if Input.is_action_just_pressed("jump") and Save1.auxiliary_dialog==false:
		var jump_destination = get_global_mouse_position()
		moving = false
		speed += acceleration * delta * 300  #lerp
		movement = position.direction_to(jump_destination) * speed
		if position.distance_to(jump_destination) > 5:
			#$Tween.interpolate_property(self, "global_position", global_position, jump_destination,0.2)
			#$Tween.start()
			movement = move_and_slide(movement)
		move_direction = rad2deg(jump_destination.angle_to_point(position))
	
func bars_start(): # hp and stamina start and reset 
	hp_bar.max_value = Save1.hp
	hp_bar.value = Save1.current_hp
	stamina_bar.max_value = Save1.stamina
	stamina_bar.value = Save1.current_stamina

func stop_player():
	moving = false

func OnHit(damage):
	hp -= damage
	hp_bar.value = hp 
	
func _on_MelleRange_body_entered(body):
	if body.is_in_group("Enemies") : 
		if((get_angle_to(body.position)/3.14)*180) <= (fire_direction +25) and ((get_angle_to(body.position)/3.14)*180) >= (fire_direction - 25):
				body.OnHit(damage)
				
# EVENT ANIMATION

func zoom_camera_animation():
	$AnimationPlayer2.play("zoom_event")
	
func think_panel(thinks:Array):
	if think_panel == false:
		think = 0
		thinks_from = thinks
		get_node("Camera2D/CanvasLayer/Think").visible = true
	think_panel = true
	get_node("Camera2D/CanvasLayer/Think/Label").text = thinks_from[think]
		
func think_panel_next():
	if Input.is_action_just_pressed("space") and think_panel == true:
		if think+1 >= thinks_from.size():
			get_node("Camera2D/CanvasLayer/Think").visible = false
			think_panel = false
		else:
			think +=1
			get_node("Camera2D/CanvasLayer/Think/Label").text = thinks_from[think]
			
func lv_up():
	if Save1.lv_up == true:
		var lv_up = preload("res://lv_up/lv_up.tscn").instance()
		$Camera2D/CanvasLayer.add_child(lv_up)
		Save1.lv_up = false


