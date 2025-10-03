extends RigidBody2D
class_name Asteroid

var screen_size

@onready var collision_a_1: CollisionPolygon2D = $CollisionA1
@onready var animated_sprite_a_1: AnimatedSprite2D = $AnimatedSpriteA1
@onready var collision_a_2: CollisionPolygon2D = $CollisionA2
@onready var animated_sprite_a_2: AnimatedSprite2D = $AnimatedSpriteA2
@onready var collision_a_3: CollisionPolygon2D = $CollisionA3
@onready var animated_sprite_a_3: AnimatedSprite2D = $AnimatedSpriteA3
@onready var collision_a_4: CollisionPolygon2D = $CollisionA4
@onready var animated_sprite_a_4: AnimatedSprite2D = $AnimatedSpriteA4

@onready var astroids: PackedScene = preload("res://asteroid.tscn")

var _myCollision: CollisionPolygon2D
var _mySprite: AnimatedSprite2D
var _scale := 1.0

enum AstroidType {A1, A2, A3, A4}
enum Speed {FAST = 150, MED = 100, SLOW = 75}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

	# Randomly generate an asteroid
	var num = randi_range(0, 3)
	match num:
		AstroidType.A1:
			_myCollision = collision_a_1
			_mySprite = animated_sprite_a_1
		AstroidType.A2:
			_myCollision = collision_a_2
			_mySprite = animated_sprite_a_2
		AstroidType.A3:
			_myCollision = collision_a_3
			_mySprite = animated_sprite_a_3
		AstroidType.A4:
			_myCollision = collision_a_4
			_mySprite = animated_sprite_a_4
		_:
			_myCollision = collision_a_1
			_mySprite = animated_sprite_a_1

	# Enable collisions, visibility and set the scale
	_mySprite.visible = true
	_myCollision.disabled = false
	_mySprite.set_scale(Vector2(_scale, _scale))
	_myCollision.set_scale(Vector2(_scale, _scale))

	# Set velocity based on the size of the asteroid
	var angle := randf_range(0, TAU)
	var speed := 0
	match _scale:
		1.0:
			speed = Speed.SLOW
		0.5:
			speed = Speed.MED
		0.25:
			speed = Speed.FAST

	# Asteroid go brrrr
	apply_central_impulse(Vector2.from_angle(angle) * speed)


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


func _on_body_entered(body: Node) -> void:
	if body is Bullet:
		var my_scale := 1.0
		match _scale:
			1.0:
				my_scale = 0.5
				_spawn_astroid(my_scale)
				_spawn_astroid(my_scale)
			0.5:
				my_scale = 0.25
				_spawn_astroid(my_scale)
				_spawn_astroid(my_scale)
			0.25:
				pass
		queue_free()


func _spawn_astroid(my_scale: float):
	var astroid = astroids.instantiate()
	astroid.position.x = position.x
	astroid.position.y = position.y 
	astroid.set_my_scale(my_scale)
	call_deferred("add_sibling",astroid)

func set_my_scale(my_scale: float):
	_scale = my_scale
