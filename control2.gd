extends Control

func _ready():
	$VBoxContainer/Button.connect("pressed", Callable(self, "_on_button_pressed"))
	$VBoxContainer2/Button.connect("pressed", Callable(self, "_on_options_pressed"))
	$VBoxContainer3/Button.connect("pressed", Callable(self, "_on_options_pressed"))
	$VBoxContainer4/Button.connect("pressed", Callable(self, "_on_exit_pressed"))

func _on_options_pressed():
	get_tree().change_scene_to_file("res://dlc.tscn") 

func _on_quit_pressed():
	get_tree().quit()

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn") # Remplace par ta scène de jeu
