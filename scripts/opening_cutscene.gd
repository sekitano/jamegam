extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_physics_process(false)
	animation_player.play("fade_out")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
