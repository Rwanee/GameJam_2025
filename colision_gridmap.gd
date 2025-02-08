extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var gravity = 9.8

func _physics_process(delta):
	# Appliquer la gravité
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Déplacement horizontal
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_backward"):
		input_dir.z += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
	
	input_dir = input_dir.normalized() * SPEED
	velocity.x = input_dir.x
	velocity.z = input_dir.z

	# Saut
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Appliquer le mouvement
	move_and_slide()
