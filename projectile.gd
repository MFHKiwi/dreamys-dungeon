extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(3).timeout
	self.queue_free()
	pass # Replace with function body.
