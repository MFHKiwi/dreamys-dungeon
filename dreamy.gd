extends CharacterBody2D

signal timeout
const SPEED = 15000.0
var bullet = preload("res://projectile.tscn")
var bullet_speed = 1000
var health = 3
@onready var face = get_tree().get_root().get_node("Node2D/Face")
@onready var hpbar = get_tree().get_root().get_node("Node2D/ProgressBar")
@onready var audioplayer = get_tree().get_root().get_node("Node2D/AudioStreamPlayer2D")
@onready var hurt = preload("res://assets/hurt.mp3")

func _ready():
	#get_tree().get_root().content_scale_factor = 2
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 0.25
	timer.start()
	timer.connect("timeout", Callable(self, "_on_timeout"))
	pass

func _on_timeout():
	if Input.is_key_pressed(KEY_W):
		fire('w')
	elif Input.is_key_pressed(KEY_S):
		fire('s')
	elif Input.is_key_pressed(KEY_A):
		fire('a')
	elif Input.is_key_pressed(KEY_D):
		fire('d')
	pass

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	match direction:
		Vector2(0,0):
			$AnimatedSprite2D.play("idle")
		Vector2(-1,0):
			$AnimatedSprite2D.play("left")
		Vector2(1,0):
			$AnimatedSprite2D.play("right")
		Vector2(0,1):
			$AnimatedSprite2D.play("back")
		Vector2(0,-1):
			$AnimatedSprite2D.play("forward")
	if direction:
		velocity = direction * SPEED * delta
	else:
		velocity = Vector2(0, 0)
	move_and_slide()
	hpbar.value = health
	if health < 1:
		get_tree().paused = true
		$AnimatedSprite2D.play("death")
		face.play("death")


func fire(direction):
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = get_global_position()
	match direction:
		'w':
			bullet_instance.rotation_degrees = 0
			bullet_instance.position += Vector2(0, -110)
			bullet_instance.apply_impulse(Vector2(0, -bullet_speed), Vector2())
		's':
			bullet_instance.rotation_degrees = 180
			bullet_instance.position += Vector2(0, 110)
			bullet_instance.apply_impulse(Vector2(0, bullet_speed), Vector2())
		'a':
			bullet_instance.rotation_degrees = 270
			bullet_instance.position += Vector2(-80, 0)
			bullet_instance.apply_impulse(Vector2(-bullet_speed, 0), Vector2())
		'd':
			bullet_instance.rotation_degrees = 90
			bullet_instance.position += Vector2(80, 0)
			bullet_instance.apply_impulse(Vector2(bullet_speed, 0), Vector2())
	get_tree().get_root().call_deferred("add_child", bullet_instance)


func _on_hit():
	health = health - 1
	face.play("hurt")
	audioplayer.stream = hurt
	audioplayer.play()
	await get_tree().create_timer(2).timeout
	face.play("default")
