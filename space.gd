extends Node

@export var astroids: Array[PackedScene]

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		print("debug pressed")
		spawn_astroids()


func spawn_astroids():
	spawn_astroid(1)
	#for num in range(0, 4):
		#spawn_astroid(1)
		#spawn_astroid(0.5)
		#spawn_astroid(0.25)
		

func spawn_astroid(size: float):
	var a_index = randi_range(0, astroids.size()-1)
	var astroid = astroids[0].instantiate()
	var rand_x = randi_range(0, screen_size.x)
	var rand_y = randi_range(0, screen_size.y)
	astroid.position.x = rand_x
	astroid.position.y = rand_y
	astroid.find_child("AnimatedSprite2D").set_scale(Vector2(size, size))
	astroid.find_child("CollisionPolygon2D").set_scale(Vector2(size, size))
	
	var angle = randf_range(0, TAU)
	astroid.apply_central_impulse(Vector2.from_angle(angle) * 150)
	add_child(astroid)
