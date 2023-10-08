extends Area2D

signal hit
signal game_won

var dreamy
var health = 100
var speed: float = 0.01
@onready var face = get_tree().get_root().get_node("Node2D/Face2")
@onready var hpbar = get_tree().get_root().get_node("Node2D/ProgressBar2")
@onready var audioplayer = get_node("AudioStreamPlayer2D")
@onready var death = preload("res://assets/deathsound.mp3")
@onready var timer := Timer.new()
@onready var explosion1 = get_node("Sprite2D1")
@onready var explosion2 = get_node("Sprite2D2")
@onready var explosion3 = get_node("Sprite2D3")
@onready var hit1 = preload("res://assets/carhit1.mp3")
#@onready var room_2 = get_tree().get_root().get_child(1)

func _ready():
	face.visible = true
	hpbar.visible = true
	add_child(timer)
	timer.wait_time = 10
	timer.start()
	timer.connect("timeout", Callable(self, "_on_timeout"))
	dreamy = get_tree().get_root().get_node("Node2D/dreamy")
	connect("hit", Callable(dreamy, "_on_hit"))
	connect("game_won", Callable(dreamy, "_on_game_won"))
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
	elif body.is_in_group("bullet"):
		body.queue_free()
		health = health - 2
		audioplayer.stream = hit1
		audioplayer.play()

func _physics_process(delta):
	self.global_position = lerp(self.global_position,dreamy.global_position,speed)
	hpbar.value = health
	if health < 1:
		die()
		#self.queue_free()

func die():
	self.set_physics_process(false)
	timer.stop()
	emit_signal("game_won")
	face.play("death")
	$AnimatedSprite2D.stop()
	audioplayer.stream = death
	audioplayer.volume_db = -5
	audioplayer.play()
	explosion1.visible = true
	await get_tree().create_timer(6).timeout
	explosion2.visible = true
	await get_tree().create_timer(4.25).timeout
	explosion3.visible = true
