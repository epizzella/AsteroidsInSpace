extends Node

@export var astroids: PackedScene

@onready var ship: Area2D = $ship

var screen_size: Vector2
var ship_start: Vector2
var points := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	ship_start = Vector2(screen_size.x / 2, screen_size.y - (screen_size.y / 4))
	ship.position = ship_start
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		print("debug pressed")
		spawn_astroids()


func spawn_astroids():
	for num in range(0, 4):
		spawn_astroid(1, Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y)))
		
	spawn_astroid(0.5, Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y)))
	spawn_astroid(0.5, Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y)))
	spawn_astroid(0.25, Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y)))
		

func spawn_astroid(size: float, a_position: Vector2):
	var astroid = astroids.instantiate()
	astroid.set_my_scale(size)
	astroid.position = a_position
	astroid.bullet_hit.connect(_handle_asteroid_hit)
	call_deferred("add_child", astroid)


func _handle_asteroid_hit(a_position: Vector2, a_scale: float):
	var my_scale := 1.0
	match a_scale:
		1.0:
			my_scale = 0.5
			spawn_astroid(my_scale, a_position)
			spawn_astroid(my_scale, a_position)
		0.5:
			my_scale = 0.25
			spawn_astroid(my_scale, a_position)
			spawn_astroid(my_scale, a_position)
	
	points += 1
