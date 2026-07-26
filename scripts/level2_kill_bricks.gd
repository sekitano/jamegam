extends Area2D
@onready var death_: AudioStreamPlayer = $"../Death_"

func _on_body_entered(body: Node2D) -> void:
	death_.play()
	call_deferred("respawn")

func respawn():
	get_tree().reload_current_scene()
