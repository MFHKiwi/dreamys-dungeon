extends Node2D

signal hit

var dreamy
var in_area = false
var shooting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 4
	timer.start()
	timer.connect("timeout", Callable(self, "_on_timeout"))
	dreamy = get_tree().get_root().get_node("Node2D/dreamy")
	connect("hit", Callable(dreamy, "_on_hit"))

func _on_timeout():
	$Turret.play("charge")
	await get_tree().create_timer(2).timeout
	shooting = true
	$Beam.play("fire")
	$Turret.play("shooting")
	await get_tree().create_timer(1).timeout
	shooting = false
	$Beam.play("idle")
	$Turret.play("idle")
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shooting and in_area:
		emit_signal("hit")
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("dreamy"):
		in_area = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.is_in_group("dreamy"):
		in_area = false
	pass # Replace with function body.
