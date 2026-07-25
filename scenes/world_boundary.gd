extends Area2D


func _on_body_entered(body):
	call_deferred("respawn")

func respawn():
	get_tree().reload_current_scene()
