extends Node2D

@onready var face = get_tree().get_root().get_node("Node2D/Face")
@onready var audioplayer = get_node("AudioStreamPlayer2D")
@onready var ohmaygot = preload("res://assets/ohmygod.mp3")
@onready var text = get_tree().get_root().get_node("Node2D/Text")
# Called when the node enters the scene tree for the first time.
func _ready():
	face.play("surprised")
	audioplayer.stream = ohmaygot
	audioplayer.play()
	text.play("lasers")
	await get_tree().create_timer(3).timeout
	text.play("default")
	face.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
