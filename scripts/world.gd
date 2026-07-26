extends Node2D

@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $Player
@onready var magic_blanket: Node2D = $magic_blanket
@onready var blanket_follow: Label = $Player/Camera2D/blanket_follow
@onready var sign1: CanvasLayer = $sign_text

const FOLLOW_SPEED = 4.0
const DISTANCE = 15.0

var entered = false
var sign_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.play("gameplay")
	
	timer.start()
	sign1.sign_finished.connect(_on_sign_finished)

func _process(delta):
	if Input.is_action_just_pressed("interact") and entered and not sign_open:
		sign_open = true
		sign1.show()
		sign1.queue_text("Pretty big jump huh... That's where your magic blanket can help!")
		sign1.queue_text("Press 'E' to toggle the blanket movement. While the magic blanket follow is off, you can move it freely by pressing 'left click'.")
		sign1.queue_text("Also, while magic blanket toggle is off, you can jump on it if the blanket sits still. Pretty cool right?")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = player.velocity.normalized()
	
	#print(magic_blanket.follow_player)
	
	if magic_blanket.follow_player:
		blanket_follow.text = "magic blanket follow: on"
	else:
		blanket_follow.text = "magic blanket follow: off"
	
	if magic_blanket.follow_player:
		if direction != Vector2.ZERO:
			var target = player.global_position - direction * DISTANCE
			magic_blanket.global_position = magic_blanket.global_position.lerp(target, delta * FOLLOW_SPEED)
		

func _on_sign_body_entered(body: Node2D) -> void:
	entered = true
	print("body entered")



func _on_sign_body_exited(body: Node2D) -> void:
	entered = false

func _on_sign_finished():
	sign1.hide()
	sign_open = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("queue the cam!")
	player.set_physics_process(false)
	player.animated_sprite.play("idle")
	call_deferred("next_level")

	
func next_level():
	get_tree().change_scene_to_file('res://scenes/level2_cs.tscn')
