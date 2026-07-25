extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var fade_out_1: AnimationPlayer = $fade_out/fade_out1
@onready var fade_out_2: AnimationPlayer = $blackscreen/fade_out2
@onready var timer_2: Timer = $Timer2

@onready var sleeping_cat: AnimatedSprite2D = $sleeping_cat
@onready var wizard: AnimatedSprite2D = $wizard
@onready var cat_covered: Sprite2D = $CatCovered
@onready var magic_blanket: AnimatedSprite2D = $Path2D/PathFollow2D/magic_blanket
@onready var textbox: CanvasLayer = $Player/Camera2D/Textbox
@onready var path_follower: PathFollow2D = $Path2D/PathFollow2D
@onready var blackscreen: ColorRect = $blackscreen
@onready var timer: Timer = $Timer
@onready var textbox_2: CanvasLayer = $Player/Camera2D/Textbox2


var is_path_following = false 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_physics_process(false)
	fade_out_1.play("fade_out")
	textbox.dialogue_finished.connect(_on_dialogue_finished)
	textbox_2.dialogue_finished2.connect(_on_dialogue_finished2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_path_following:
		path_follower.progress_ratio += 0.015
		
		if path_follower.progress_ratio >= 1:
			is_path_following = false
			blackscreen.show()
			timer.start()


func _on_dialogue_finished():
	is_path_following = true 


func _on_timer_timeout() -> void:
	print("fade out")
	fade_out_2.play("fade_out2")
	magic_blanket.hide()
	sleeping_cat.hide()
	cat_covered.show()
	wizard.show()
	timer_2.start()
	wizard.play("pant")
	

func _on_timer_2_timeout() -> void:
	textbox_2.show()
	textbox_2.queue_text("???: *huff huff*")

	
func _on_dialogue_finished2():
	wizard.stop()
	wizard.play("open_eyes")
