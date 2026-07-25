extends Node2D

@onready var fade_out: AnimationPlayer = $ColorRect/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_out.play("fade_out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
