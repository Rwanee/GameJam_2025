extends Area3D

const ROT_SPEED = 2 # number of degrees the coin rotates every frame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))

func _on_body_entered(body: Node3D) -> void:
	Global.coins += 1
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	if Global.coins >= 3:
		get_tree().change_scene_from_file()
	$AnimationPlayer.play("bounce")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
