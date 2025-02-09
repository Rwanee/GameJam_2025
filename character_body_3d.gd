extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 3.0
const GRAVITY = 9.8
const ROTATION_SPEED = 5.0

@export var teleport_position: Vector3 = Vector3(0, 2, 0)
@onready var mesh_holder: Node3D = $MeshHolder
@onready var camera: Camera3D = get_viewport().get_camera_3d()
@export var respawn_position: Vector3 = Vector3(4.75, 2, 4.75)

func _ready():
	mesh_holder = $MeshHolder

func _physics_process(delta: float) -> void:
	# Appliquer la gravité
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# Gestion du saut
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Obtenir la direction d'entrée
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	if input_dir != Vector2.ZERO:
		# Obtenir la transformation de la caméra
		var cam_basis = camera.global_transform.basis
		
		# Créer le vecteur de direction en utilisant la base de la caméra
		var direction = Vector3.ZERO
		direction = cam_basis.z * input_dir.y + cam_basis.x * input_dir.x
		direction.y = 0  # On garde le mouvement horizontal
		direction = direction.normalized()
		
		# Appliquer le mouvement
		var target_velocity = direction * SPEED
		velocity.x = lerp(velocity.x, target_velocity.x, 10.0 * delta)
		velocity.z = lerp(velocity.z, target_velocity.z, 10.0 * delta)
		
		# Rotation fluide du mesh vers la direction du mouvement
		if direction:
			var target_rotation = atan2(-direction.x, -direction.z)
			mesh_holder.rotation.y = lerp_angle(mesh_holder.rotation.y, target_rotation, delta * ROTATION_SPEED)
	else:
		# Décélération
		velocity.x = move_toward(velocity.x, 0, SPEED * 5.0 * delta)
		velocity.z = move_toward(velocity.z, 0, SPEED * 5.0 * delta)
		
		# Correction des valeurs résiduelles
		if abs(velocity.x) < 0.1:
			velocity.x = 0
		if abs(velocity.z) < 0.1:
			velocity.z = 0
	if Input.is_action_just_pressed("respawn"):
		respawn()
		
	move_and_slide()

func teleport():
	global_transform.origin = teleport_position

func respawn():
	global_transform.origin = respawn_position  # Téléporte le joueur à la position donnée
	velocity = Vector3.ZERO  # Réinitialise la vitesse pour éviter un bug de chute
