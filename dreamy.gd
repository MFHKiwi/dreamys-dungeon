extends CharacterBody2D

signal timeout
const SPEED = 15000.0
var bullet = preload("res://projectile.tscn")
var bullet_speed = 1000

func _ready():
	get_tree().get_root().content_scale_factor = 2
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
	var old_level = get_tree().get_root().get_node("Node2D/Starting_room")
	get_tree().get_root().remove_child(old_level)
	old_level.call_deferred("free")
	var next_level_resource = load("res://room_1.tscn")
	var next_level = next_level_resource.instantiate()
	get_tree().get_root().add_child(next_level)
	get_tree().get_root().content_scale_factor = 1


func _on_hit():
	position = Vector2(100,100)
