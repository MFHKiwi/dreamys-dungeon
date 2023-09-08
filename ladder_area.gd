extends Area2D


func _on_body_entered(body):
	if body.is_in_group("dreamy") && get_parent().get_child(1).visible:
		var old_level = get_tree().get_root().get_child(1)
		var next_level_resource = load("res://room_2.tscn")
		var next_level = next_level_resource.instantiate()
		get_tree().get_root().add_child(next_level)
		old_level.queue_free()
