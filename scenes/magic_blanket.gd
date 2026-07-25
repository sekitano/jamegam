extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 30

var last_pos: Vector2 
var follow_player := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	last_pos = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var is_moving = global_position.distance_to(last_pos) > 1.0
	
	if is_moving:
		animated_sprite_2d.play("float")
	
	else:
		animated_sprite_2d.stop()
		
	last_pos = global_position
	
	if Input.is_action_just_pressed("E"):
		follow_player = !follow_player
		print("follow_player:", follow_player)
		
	if Input.is_action_pressed("left_click") and not follow_player:
		global_position = global_position.lerp(get_global_mouse_position(), SPEED * delta)

	
	
