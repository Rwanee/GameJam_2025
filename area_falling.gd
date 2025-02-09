extends Area3D

@export var teleport_position: Vector3 = Vector3(0, 10, 0)  # Coordonnées de téléportation

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody3D:  # Vérifie si c'est un personnage
		body.global_transform.origin = teleport_position  # Téléporte le personnage
		
