extends Area2D

signal hit

func _ready():
	var dreamy = get_node("../dreamy")
	connect("hit", Callable(dreamy, "_on_hit"))

func _on_body_entered(body):
	if body.is_in_group("dreamy"):
		emit_signal("hit")
