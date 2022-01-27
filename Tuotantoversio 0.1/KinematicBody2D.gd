extends KinematicBody2D # KinematicBody2D luokkaa laajennetaan

const UP = Vector2(0,-1) # Määrittää vakion suunnan
const GRAVITY = 21 # Painovoima
const MAXFALLSSPEED = 400 # Makisimi putoamisnopeus
const MAXSPEED = 200 # Maksimi nopeus
const JUMPFORCE = 450 # Hypyn voimakkuus

var motion = Vector2() # 

func _ready():
	pass # Korvaa funktion rungon


func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSSPEED: # Fysiikan lait
		motion.y = MAXFALLSSPEED

	if Input.is_action_pressed("right"): # kun painat oikealle
		motion.x = MAXSPEED
	elif Input.is_action_pressed("left"): # kun painat vasemmalle
		motion.x = -MAXSPEED
	else:
		motion.x = 0

	if is_on_floor():
		if Input.is_action_just_pressed("jump"): # Kun painat välilyöntiä
			motion.y = -JUMPFORCE

	motion = move_and_slide(motion,UP)

func _on_Area2D_area_entered(area):
	if area.is_in_group("Enemy"):
		queue_free()


func _on_Area2D_body_entered(body): # Kun hahmo osuu alueeseen
	get_tree().change_scene("res://World.tscn") # Vaihtuu skene
