class_name Bullet
extends RigidBody2D

var screen_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var x := 0.0
	var y := 0.0

	if position.x >= screen_size.x:
		x = -1 * screen_size.x
	elif position.x <= 0:
		x = screen_size.x

	if position.y >= screen_size.y:
		y = -1 * screen_size.y
	elif position.y <= 0:
		y = screen_size.y

	state.transform = state.transform.translated(Vector2(x, y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
	
# 	# screen wrap
# 	position.x = wrapf(position.x, 0, screen_size.x)
# 	position.y = wrapf(position.y, 0, screen_size.y)


func _on_body_entered(body: Node) -> void:
	# remove the bullet when collision detected
	print("Bullet hit!")
	queue_free()


func _on_timer_timeout() -> void:
	# remove the bullet on timeout
	queue_free()
