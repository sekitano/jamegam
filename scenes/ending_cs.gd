extends Node2D

@onready var player: CharacterBody2D = $Path2D/PathFollow2D/Player

@onready var magic_blanket: Node2D = $Path2D/PathFollow2D/magic_blanket

#@onready var blanket_follow: Label = $blanket_follow
@onready var path_follower: PathFollow2D = $Path2D/PathFollow2D
#@onready var camera: Camera2D = $Path2D/PathFollow2D/Camera2D3
#@onready var blanket_body = $magic_blanket/StaticBody2D
@onready var camera_2d: Camera2D = $Path2D/PathFollow2D/Player/Camera2D

@onready var blanket_follow: Label = $Path2D/PathFollow2D/Player/Camera2D/blanket_follow
@onready var path_follower2: PathFollow2D = $Path2D2/PathFollow2D
@onready var camera2: Camera2D = $Path2D2/PathFollow2D/Camera2D

@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var timer: Timer = $Timer



#@onready var blanket_follow: Label = $Player/Camera2D/blanket_follow

var default_zoom := Vector2(3.19, 3.19)
var zoomed_out := Vector2(1.15, 1.15)
var zoom_in_speed_sec := 0.3
var zoom_out_speed_sec := 1

const FOLLOW_SPEED = 4.0
const DISTANCE = 15.0

var is_path_following = false
var is_path_following2 = false
#var tween = get_tree().create_tween()
#tween.tween_property(camera, "zoom", zoomed_out, zoom_out_speed_sec)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	blanket_follow.hide()
	player.set_physics_process(false)
	
func _process(delta):
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_path_following:
		path_follower.progress_ratio += 0.009
		#player.update_blend_positions(Vector2(1,0))
		
		if player.animated_sprite.animation != "run":
			player.animated_sprite.play("run")
		#var tween = get_tree().create_tween()
		#tween.tween_property(camera, "zoom", default_zoom, zoom_in_speed_sec)
		if path_follower.progress_ratio >= 1:
			#get_tree().change_scene_to_file("res://scenes/level4.tscn")
			#player_cam.make_current()
			player.animated_sprite.play("idle")
			is_path_following = false
			is_path_following2 = true
	
	if is_path_following2:
		camera2.make_current()
		path_follower2.progress_ratio += 0.02
		#player.update_blend_positions(Vector2(1,0))
		
		if player.animated_sprite.animation != "idle":
			player.animated_sprite.play("idle")
		#var tween = get_tree().create_tween()
		#tween.tween_property(camera, "zoom", default_zoom, zoom_in_speed_sec)
		if path_follower2.progress_ratio >= 1:
			is_path_following2 = false
			#get_tree().change_scene_to_file("res://scenes/level4.tscn")
			#player_cam.make_current()
	var direction = player.velocity.normalized()
	
	#print(magic_blanket.follow_player)
	
	if magic_blanket.follow_player:
		blanket_follow.text = "magic blanket follow: on"
	else:
		blanket_follow.text = "magic blanket follow: off"
	
	if magic_blanket.follow_player:
		if direction != Vector2.ZERO:
			var target = player.global_position - direction * DISTANCE
			magic_blanket.global_position = magic_blanket.global_position.lerp(target, delta * FOLLOW_SPEED)


func _on_timer_timeout() -> void:
	animation_player.play("fade_out")
	is_path_following = true
