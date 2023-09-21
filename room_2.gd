extends Node2D

@onready var face = get_tree().get_root().get_node("Node2D/Face")
@onready var text = get_tree().get_root().get_node("Node2D/Text")
@onready var audioplayer = get_node("AudioStreamPlayer2D")
@onready var ohmaygot = preload("res://assets/ohmygod.mp3")
@onready var bus = preload("res://assets/bus.mp3")
@onready var laopo = preload("res://assets/laopo.mp3")
# Called when the node enters the scene tree for the first time.
func _ready():
	audioplayer.stream = laopo
	audioplayer.play()
	await get_tree().create_timer(0.5).timeout
	face.play("surprised")
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
