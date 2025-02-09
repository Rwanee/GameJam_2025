extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const GRAVITY = 9.8
const ROTATION_SPEED = 10.0  # Augmenté pour une rotation plus rapide

@export var teleport_position: Vector3 = Vector3(0, 2, 0)

func _physics_process(delta: float) -> void:
	# Appliquer la gravité
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# Gestion du saut
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Déplacement avec ZQSD
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		# Rotation plus rapide du personnage vers la direction du déplacement
		var target_rotation = atan2(-direction.x, -direction.z)  # Calcul de l'angle
		rotation.y = lerp_angle(rotation.y, target_rotation, ROTATION_SPEED * delta)  # Rotation rapide

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func teleport():
	global_transform.origin = teleport_position  # Téléporte le personnage
	
