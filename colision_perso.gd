extends CharacterBody3D

@export var speed : float = 5.0

func _physics_process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector3.ZERO

	move_and_slide()
