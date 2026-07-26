extends Node2D

@onready var timer: Timer = $Timer
@onready var label_2: Label = $Label2
@onready var timer_2: Timer = $Timer2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	label_2.show()
	timer_2.start()


func _on_timer_2_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_screen.tscn")
