extends Node2D

@onready var dreamy = get_tree().get_root().get_node("Node2D/dreamy")
@onready var face = get_tree().get_root().get_node("Node2D/Face")
@onready var text = get_tree().get_root().get_node("Node2D/Text")
@onready var text2 = get_tree().get_root().get_node("Node2D/Text2")
@onready var enemy = get_node("enemy")
@onready var audioplayer = get_node("AudioStreamPlayer2D")
@onready var ohmaygot = preload("res://assets/ohmygod.mp3")
@onready var bus = preload("res://assets/bus.mp3")
@onready var laopo = preload("res://assets/laopo.mp3")
@onready var start = preload("res://assets/carstarting.mp3")
# Called when the node enters the scene tree for the first time.
func _ready():
	enemy.set_physics_process(false)
	enemy.get_child(1).play("frozen")
	dreamy.set_physics_process(false)
	dreamy.get_child(0).play("idle")
	enemy.visible = false
	text.play("final1")
	await get_tree().create_timer(1).timeout
	text.play("final2")
	await get_tree().create_timer(1).timeout
	text.play("default")
	enemy.visible = true
	audioplayer.stream = laopo
	audioplayer.play()
	face.play("surprised")
	text2.play("nissan1")
	await get_tree().create_timer(1.5).timeout
	text2.play("nissan2")
	await get_tree().create_timer(1.5).timeout
	text2.play("nissan3")
	audioplayer.stream = start
	audioplayer.play()
	audioplayer.volume_db = 10
	await get_tree().create_timer(2).timeout
	audioplayer.volume_db = 0
	text2.play("default")
	enemy.set_physics_process(true)
	enemy.get_child(1).play("default")
	dreamy.set_physics_process(true)
	#await get_tree().create_timer(0.5).timeout
	audioplayer.stream = ohmaygot
	audioplayer.play()
	text.play("omg")
	await get_tree().create_timer(2).timeout
	audioplayer.stream = bus
	audioplayer.volume_db = 10
	audioplayer.play()
	text.play("bus")
	await get_tree().create_timer(2).timeout
	face.play("default")
	text.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
