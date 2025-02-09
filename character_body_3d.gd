extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 3.0
const GRAVITY = 9.8
const ROTATION_SPEED = 15.0  # Rotation plus rapide

@export var teleport_position: Vector3 = Vector3(0, 2, 0)

var mesh_holder: Node3D  # Référence au Node qui contient le modèle 3D

func _ready():
	mesh_holder = $MeshHolder  # Récupère le Node3D contenant le visuel

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
		
		# Rotation du visuel seulement (pas le CharacterBody3D)
		var target_rotation = atan2(-direction.x, -direction.z)
		mesh_holder.rotation.y = lerp_angle(mesh_holder.rotation.y, target_rotation, ROTATION_SPEED * delta)

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func teleport():
	global_transform.origin = teleport_position  # Téléporte le personnage
