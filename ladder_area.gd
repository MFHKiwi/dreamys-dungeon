extends Area2D


func _on_body_entered(body):
	if body.is_in_group("dreamy") && get_parent().get_child(1).visible:
		get_tree().change_scene_to_file("res://room_2.tscn")
