extends Area2D

@onready var death_: AudioStreamPlayer = $"../Death_"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	death_.play()
	call_deferred("respawn")

func respawn():
	get_tree().reload_current_scene()
