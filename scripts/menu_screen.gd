extends Node2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

var button_type = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	button_type = "start"
	color_rect.show()
	animation_player.play("fade_in")
	timer.start()
	print("start pressed")


func _on_exit_pressed() -> void:
	print("quit pressed")
	get_tree().quit()


func _on_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file('res://scenes/opening_cutscene.tscn')
