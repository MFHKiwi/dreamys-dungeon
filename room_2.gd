extends Node2D

@onready var face = get_tree().get_root().get_node("Node2D/Face")
@onready var text = get_tree().get_root().get_node("Node2D/Text")
# Called when the node enters the scene tree for the first time.
func _ready():
	face.play("surprised")
	text.play("omgbus")
	await get_tree().create_timer(3).timeout
	face.play("default")
	text.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
