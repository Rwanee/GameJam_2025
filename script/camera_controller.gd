extends Camera3D

var rotation_speed = 180.0 # Vitesse de rotation en degrés/seconde
var target_rotation = 0.0
var rotating = false

func _input(event):
	if event.is_action_pressed("ui_left"):
		target_rotation += 90
		rotating = true
	elif event.is_action_pressed("ui_right"):
		target_rotation -= 90
		rotating = true

func _process(delta):
	if rotating:
		rotation_degrees.y = move_toward(rotation_degrees.y, target_rotation, rotation_speed * delta)
		if abs(rotation_degrees.y - target_rotation) < 0.5:
			rotation_degrees.y = target_rotation
			rotating = false
