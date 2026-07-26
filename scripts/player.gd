extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump: AudioStreamPlayer = $Jump


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump.play()
		velocity.y = JUMP_VELOCITY

	# Get input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Apply Animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else: 
			animated_sprite.play("run")
	else:
		if velocity.y < 0: # True when going up
			animated_sprite.play("jump") # Go up
		else: 
			animated_sprite.play("fall") # Go down
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
