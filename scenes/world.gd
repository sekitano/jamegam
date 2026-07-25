extends Node2D

@onready var fade_out: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $Player
@onready var magic_blanket: StaticBody2D = $magic_blanket
@onready var blanket_follow: Label = $Player/Camera2D/blanket_follow

const FOLLOW_SPEED = 4.0
const DISTANCE = 15.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = player.velocity.normalized()
	
	if magic_blanket.follow_player:
		blanket_follow.text = "magic blanket follow: on"
	else:
		blanket_follow.text = "magic blanket follow: off"
	
	if direction != Vector2.ZERO and magic_blanket.follow_player:
		var target = player.global_position - direction * DISTANCE
		magic_blanket.global_position = magic_blanket.global_position.lerp(target, delta * FOLLOW_SPEED)


func _on_timer_timeout() -> void:
	fade_out.play("fade_out")
