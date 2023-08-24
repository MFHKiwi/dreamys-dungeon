extends Area2D

signal hit

var dreamy
var health = 100
var speed: float = 0.01
@onready var room_1 = get_node("../Room1")

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
	$AnimatedSprite2D.pause()
	await get_tree().create_timer(1).timeout
	speed = 0.0275
	$AnimatedSprite2D.speed_scale = 2
	$AnimatedSprite2D.play()
	await get_tree().create_timer(3).timeout
	speed = 0.01
	$AnimatedSprite2D.speed_scale = 1

func _on_body_entered(body):
	if body.is_in_group("dreamy"):
		emit_signal("hit")
		self.position = Vector2(1150, 910)
	elif body.is_in_group("bullet"):
		body.queue_free()
		health = health - 2

func _physics_process(delta):
	self.position = lerp(self.position,dreamy.global_position,speed)
	if health < 1:
		print("NISSANNNNNN")
		get_parent().remove_child(self)
		room_1.get_child(1).visible = true
