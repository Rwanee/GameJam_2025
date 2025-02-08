extends CharacterBody3D

@export var speed = 5.0
@export var jump_force = 5.0
@export var gravity = 9.8

func _physics_process(delta):
	# Appliquer la gravité
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		# Réinitialiser la vélocité verticale quand on touche le sol
		velocity.y = 0.0
	
	# Déplacement horizontal (ZQSD / WASD)
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction += Vector3.FORWARD
	
	# S'assurer que velocity.y n'est pas modifié par le mouvement horizontal
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	move_and_slide()  # Ne pas oublier d'appeler move_and_slide()
	
