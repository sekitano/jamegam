extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatableBody2D/AnimatedSprite2D
@onready var static_body: StaticBody2D = $StaticBody2D
@onready var anim_body: AnimatableBody2D = $AnimatableBody2D


const SPEED = 10.0

var last_pos: Vector2 
var follow_player := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	last_pos = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var is_moving = global_position.distance_to(last_pos) > 1.0
	
	if is_moving:
		animated_sprite_2d.play("float")
	
	else:
		animated_sprite_2d.stop()
		
	last_pos = global_position
	
	if Input.is_action_just_pressed("toggle_blanket"):
		follow_player = !follow_player
		print("E pressed")
		
		if follow_player:
			set_moving(true)
		else:
			set_moving(false)
		#print("follow_player:", follow_player)
		
	if Input.is_action_pressed("left_click") and not follow_player:
		var target = get_global_mouse_position()
		
		global_position = global_position.lerp(target, SPEED * delta)

func set_moving(moving: bool):
	if moving:
		anim_body.visible = true
		static_body.process_mode = Node.PROCESS_MODE_DISABLED
		static_body.collision_layer = 0
		static_body.collision_mask = 0
	else:
		anim_body.visible = true
		static_body.process_mode = Node.PROCESS_MODE_INHERIT
		static_body.collision_layer = 1
		static_body.collision_mask = 1

	
	
