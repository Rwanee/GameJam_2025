extends Control

func _ready():
	$VBoxContainer/PLAY.connect("pressed", Callable(self, "_on_play_pressed"))
	$VBoxContainer/QUIT.connect("pressed", Callable(self, "_on_quit_pressed"))

func _on_play_pressed():
	get_tree().change_scene_to_file("res://level.tscn") # Remplace par ta scène de jeu
	print("JSUIS LA")

func _on_quit_pressed():
	get_tree().quit()
