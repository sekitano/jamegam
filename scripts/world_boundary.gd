extends Area2D
@onready var death_: AudioStreamPlayer = $"../Death_"


func _on_body_entered(body):
	death_.play()
	

func respawn():
	get_tree().reload_current_scene()


func _on_death__finished() -> void:
	call_deferred("respawn")
