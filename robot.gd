extends Area2D

signal hit

var dreamy
var health = 100
var speed: float = 0.01
var room_1
@onready var audioplayer = get_node("AudioStreamPlayer2D")
@onready var hit2 = preload("res://assets/carhit2.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	dreamy = get_tree().get_root().get_node("Node2D/dreamy")
	connect("hit", Callable(dreamy, "_on_hit"))
	room_1 = get_tree().get_root().get_child(1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("dreamy"):
		emit_signal("hit")
	elif body.is_in_group("bullet"):
		body.queue_free()
		health = health - 2
		audioplayer.stream = hit2
		audioplayer.play()

func _physics_process(delta):
	self.global_position = lerp(self.global_position,dreamy.global_position,speed)
	if health < 1:
		room_1.get_child(1).visible = true
		self.queue_free()
