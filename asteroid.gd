extends RigidBody2D

var screen_size

@onready var collision_a_1: CollisionPolygon2D = $CollisionA1
@onready var animated_sprite_a_1: AnimatedSprite2D = $AnimatedSpriteA1
@onready var collision_a_2: CollisionPolygon2D = $CollisionA2
@onready var animated_sprite_a_2: AnimatedSprite2D = $AnimatedSpriteA2
@onready var collision_a_3: CollisionPolygon2D = $CollisionA3
@onready var animated_sprite_a_3: AnimatedSprite2D = $AnimatedSpriteA3
@onready var collision_a_4: CollisionPolygon2D = $CollisionA4
@onready var animated_sprite_a_4: AnimatedSprite2D = $AnimatedSpriteA4

var _myCollision: CollisionPolygon2D
var _mySprite: AnimatedSprite2D
var _scale := 1.0

enum AstroidType {A1, A2, A3, A4}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
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

	_mySprite.visible = true
	_myCollision.disabled = false
	_mySprite.set_scale(Vector2(_scale, _scale))
	_myCollision.set_scale(Vector2(_scale, _scale))


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
		print("astroid hit by bullet")
		queue_free()


func set_my_scale(scale: float):
	_scale = scale
