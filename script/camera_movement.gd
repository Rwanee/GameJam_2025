extends Node3D

@export var rotation_speed: float = 3.0    # Vitesse de rotation
@export var base_height: float = 10.0      # Hauteur de base de la caméra
@export var mouse_sensitivity: float = 0.005
@export var smooth_speed: float = 5.0
@export var zoom_speed: float = 2.0        # Vitesse de zoom
@export var min_zoom: float = 5.0          # Distance minimum de zoom
@export var max_zoom: float = 30.0         # Distance maximum de zoom

# Référence à la caméra
@onready var camera: Camera3D = $Camera3D

# Variables pour le mouvement fluide
var current_angle: float = 0.0
var target_angle: float = 0.0
var current_zoom: float = 20.0            # Distance actuelle de zoom
var target_zoom: float = 20.0             # Distance cible de zoom

# Variables pour la rotation par paliers
const QUARTER_TURN = PI / 2               # 90 degrés en radians

func _ready():
	assert(camera != null, "Erreur : Pas de Camera3D trouvée comme enfant du Node3D")
	# Initialisation de la position de la caméra
	update_camera_position()

func _process(delta):
	# Lissage des mouvements avec lerp_angle pour une meilleure gestion des rotations
	if abs(current_angle - target_angle) > 0.001:
		current_angle = lerp_angle(current_angle, target_angle, smooth_speed * delta)
	
	# Lissage du zoom
	current_zoom = lerp(current_zoom, target_zoom, smooth_speed * delta)
	
	update_camera_position()

func _input(event):
	if event.is_action_pressed("ui_left"):
		print("Flèche gauche pressée")
		# Rotation 90° vers la gauche
		target_angle -= QUARTER_TURN
		
	elif event.is_action_pressed("ui_right"):
		print("Flèche droite pressée")
		# Rotation 90° vers la droite
		target_angle += QUARTER_TURN
		
	# Zoom avec les flèches avant/arrière
	elif event.is_action_pressed("ui_up"):
		# Zoom in (rapproche la caméra)
		target_zoom = max(current_zoom - zoom_speed, min_zoom)
		
	elif event.is_action_pressed("ui_down"):
		# Zoom out (éloigne la caméra)
		target_zoom = min(current_zoom + zoom_speed, max_zoom)
	
	# Rotation avec la souris (optionnel)
	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		target_angle -= event.relative.x * mouse_sensitivity

func update_camera_position():
	# Application de la rotation au Node3D
	rotation.y = current_angle
	
	# Calcul de la hauteur proportionnelle au zoom
	# Plus on est proche (zoom petit), plus la hauteur diminue
	var height_ratio = current_zoom / max_zoom  # Ratio entre 0 et 1
	var current_height = base_height * height_ratio
	
	# Mise à jour de la position de la caméra
	camera.position = Vector3(
		0,                  # Position X
		current_height,     # Position Y (proportionnelle au zoom)
		current_zoom        # Position Z (distance)
	)
	
	# Faire regarder la caméra vers le centre
	camera.look_at(Vector3.ZERO, Vector3.UP)
