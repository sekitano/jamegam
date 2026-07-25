extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var fade_out_1: AnimationPlayer = $fade_out/fade_out1
@onready var fade_out_2: AnimationPlayer = $blackscreen/fade_out2
@onready var timer_2: Timer = $Timer2
@onready var timer_3: Timer = $Timer3

@onready var rufzeichen: AnimatedSprite2D = $"!"
@onready var timer_5: Timer = $Timer5
#@onready var blackscreen_2: ColorRect = $blackscreen2

@onready var sleeping_cat: AnimatedSprite2D = $sleeping_cat
@onready var wizard: AnimatedSprite2D = $wizard
@onready var cat_covered: AnimatedSprite2D = $cat_covered
@onready var magic_blanket: AnimatedSprite2D = $Path2D/PathFollow2D/magic_blanket
@onready var textbox: CanvasLayer = $Player/Camera2D/Textbox
@onready var path_follower: PathFollow2D = $Path2D/PathFollow2D
@onready var blackscreen: ColorRect = $blackscreen
@onready var timer: Timer = $Timer
@onready var textbox_2: CanvasLayer = $Player/Camera2D/Textbox2
@onready var textbox_3: CanvasLayer = $Player/Camera2D/Textbox3
@onready var timer_4: Timer = $Timer4
@onready var timer_6: Timer = $Timer6
@onready var fade_in: AnimationPlayer = $blackscreen2/AnimationPlayer


var is_path_following = false 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_physics_process(false)
	fade_out_1.play("fade_out")
	textbox.dialogue_finished.connect(_on_dialogue_finished)
	textbox_2.dialogue_finished2.connect(_on_dialogue_finished2)
	textbox_3.dialogue_finished3.connect(_on_dialogue_finished3)

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
	timer_3.start()
	
	
func _on_timer_3_timeout() -> void:
	textbox_3.show()
	textbox_3.queue_text("???: Hey there, are you okay?")
	textbox_3.queue_text("???: Sorry about that. This is quite unusual.")
	cat_covered.play("wake_up")
	textbox_3.queue_text("???: It seems like my magic blanket has chosen you...")
	textbox_3.queue_text("???: This must be fate!")
	textbox_3.queue_text("???: Oh, by the way, I'm the great wizard who reigns over this land")
	textbox_3.queue_text("Wizard: Since you are the new owner of the magic blanket, you need to prove yourself worthy of wielding it.")
	textbox_3.queue_text("Wizard: Lately, the land has been corrupted by magic trash.")
	textbox_3.queue_text("Wizard: I haven't qutie figured out what's causing it...")
	textbox_3.queue_text("Wizard: Free the land of it's corruption and get the the bottom of this, and the blanket is yours!")

func _on_dialogue_finished3():
	rufzeichen.show()
	rufzeichen.play("pop_up")
	timer_4.start()


func _on_timer_4_timeout() -> void:
	rufzeichen.play("pop_down")
	timer_5.start()

func _on_timer_5_timeout() -> void:
	fade_in.play("fade_in")
	timer_6.start()

func _on_timer_6_timeout() -> void:
	get_tree().change_scene_to_file('res://scenes/level1.tscn')
