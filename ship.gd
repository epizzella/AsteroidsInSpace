extends Area2D

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
		speed += (1 * delta )
	if Input.is_action_pressed("rotate_left"):
		rot -= 3
	if Input.is_action_pressed("rotate_right"):
		rot += 3
	if Input.is_action_pressed("shoot"):
		pass
		
	rot *= delta
	$AnimatedSprite2D.rotate(rot)
	
	# offset rotation by 90 degrees to match sprite
	var angle = $AnimatedSprite2D.rotation - (PI / 2)
	
	velocity += Vector2(speed * cos(angle), speed * sin(angle))
	position += velocity
	
	# screen wrap
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
