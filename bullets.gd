extends RigidBody2D

var screen_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# screen wrap
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)


func _on_body_entered(body: Node) -> void:
	# remove the bullet when collision detected
	queue_free()


func _on_timer_timeout() -> void:
	# remove the bullet on timeout
	queue_free()
