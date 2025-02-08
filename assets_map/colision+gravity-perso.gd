extends CharacterBody3D

# Character properties
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var MOUSE_SENSITIVITY = 0.003

# Get the gravity from the project settings
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	# Lock mouse cursor to center of screen
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Make sure collision shape and camera are set up properly
	var collision = $CollisionShape3D
	var camera = $Camera3D
	
	if !collision:
		push_error("CollisionShape3D node is missing!")
	if !camera:
		push_error("Camera3D node is missing!")

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Handle movement
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Move the character
	move_and_slide()
	
	# Handle collisions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider():
			# You can add specific collision responses here
			pass

func _input(event):
	# Handle mouse movement for camera rotation
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		$Camera3D.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -PI/2, PI/2)
