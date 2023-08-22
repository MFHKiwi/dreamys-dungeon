extends Area2D

signal hit

var dreamy
var health = 100
var speed: float = 0.01

func _ready():
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 10
	timer.start()
	timer.connect("timeout", Callable(self, "_on_timeout"))
	dreamy = get_node("../dreamy")
	connect("hit", Callable(dreamy, "_on_hit"))
	$AnimatedSprite2D.play("default")

func _on_timeout():
	speed = 0.0
	await get_tree().create_timer(1).timeout
	speed = 0.0275
	await get_tree().create_timer(3).timeout
	speed = 0.01

func _on_body_entered(body):
	if body.is_in_group("dreamy"):
		emit_signal("hit")
		self.position = Vector2(1150, 910)
	elif body.is_in_group("bullet"):
		body.queue_free()
		#get_tree().get_root().call_deferred("remove_child", body)
		health = health - 2

func _physics_process(delta):
	if health < 1:
		print("NISSANNNNNN")
		get_parent().remove_child(self)
	self.position = lerp(self.position,dreamy.global_position,speed)
