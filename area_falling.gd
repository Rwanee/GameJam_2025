extends Area3D

@export var teleport_position: Vector3 = Vector3(4.75, 10, 4.75)  # Coordonnées de téléportation
@export var max_lives: int = 3  # Nombre de vies avant de reset
var player_lives: int = 0  # Compteur de morts

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody3D:  # Vérifie si c'est un personnage
		player_lives += 1  # Ajoute une mort au compteur

		if player_lives >= max_lives:
			get_tree().change_scene_to_file("res://node_2d.tscn")
			#restart_game()  # Relance le jeu si 3 morts
		else:
			body.global_transform.origin = teleport_position  # Téléporte le personnage

func restart_game():
	get_tree().reload_current_scene()  # Recharge la scène actuelle
	
