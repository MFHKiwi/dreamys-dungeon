extends CharacterBody2D

signal hit
const SPEED = 15000.0

func _process(delta):
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
	pass

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED * delta
	else:
		velocity = Vector2(0, 0)
	move_and_slide()
	var collision
	for i in get_slide_collision_count():
		collision = get_slide_collision(i)
	if collision:
		if !is_instance_of(collision.get_collider(), TileMap):
			emit_signal("hit")

func _on_hit():
	position = Vector2(200,200)
