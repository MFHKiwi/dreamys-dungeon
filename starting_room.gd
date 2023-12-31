extends Node2D

@onready var text = get_tree().get_root().get_node("Node2D/Text")
# Called when the node enters the scene tree for the first time.
func _ready():
	text.play("start1")
	await get_tree().create_timer(2).timeout
	text.play("start2")
	await get_tree().create_timer(2).timeout
	text.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("dreamy"):
		var old_level = get_tree().get_root().get_node("Node2D/Starting_room")
		old_level.queue_free()
		var next_level_resource = load("res://room_1.tscn")
		var next_level = next_level_resource.instantiate()
		get_tree().get_root().add_child(next_level)
