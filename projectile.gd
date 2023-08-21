extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(3).timeout
	get_parent().remove_child(self)
	pass # Replace with function body.
