extends Area2D

@export var bullet_scene: PackedScene

var velocity: Vector2 = Vector2.ZERO
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	velocity = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var rot = 0.0
	var speed = 0.0
	if Input.is_action_pressed("increase_speed"):
		speed = 8
	if Input.is_action_pressed("rotate_left"):
		rot -= 3
	if Input.is_action_pressed("rotate_right"):
		rot += 3

	rot *= delta
	rotate(rot)
	
	# offset rotation by 90 degrees to match sprite
	var angle = rotation - (PI / 2)
	
	if speed == 0.0:
		# brakes
		velocity = velocity.move_toward(Vector2.ZERO, .1)
	else:
		velocity += Vector2(cos(angle), sin(angle)) * speed * delta
		# speed limit
		velocity = velocity.limit_length(7)
	
	position += velocity
	
	# screen wrap
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	
	if Input.is_action_pressed("shoot"):
		shoot()


var bullet_ready = true
func shoot():
	if bullet_ready:
		var b = bullet_scene.instantiate()
		var angle = rotation - (PI / 2)
		var vec = Vector2(cos(angle), sin(angle))
		b.position = position + (vec * 15)
		b.apply_central_impulse(vec * 800)
		add_sibling(b)
		bullet_ready = false 
		$Timer.start()


func _on_body_entered(body: Node2D) -> void:
	if body is Asteroid:
		print("Ship body entered!")


func _on_timer_timeout() -> void:
	bullet_ready = true
