extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var magic_blanket: Node2D = $magic_blanket
@onready var blanket_follow: Label = $blanket_follow
@onready var path_2d: Path2D = $Path2D
@onready var path_follower: PathFollow2D = $Path2D/PathFollow2D
@onready var camera: Camera2D = $Path2D/PathFollow2D/Camera2D
@onready var player_cam: Camera2D = $Player/Camera2D



#@onready var blanket_follow: Label = $Player/Camera2D/blanket_follow

var default_zoom := Vector2(3.19, 3.19)
var zoomed_out := Vector2(1.15, 1.15)
var zoom_in_speed_sec := 0.3
var zoom_out_speed_sec := 1
@onready var camera_2d_2: Camera2D = $Path2D/PathFollow2D/Camera2D2

const FOLLOW_SPEED = 4.0
const DISTANCE = 15.0

var is_path_following = false
#var tween = get_tree().create_tween()
#tween.tween_property(camera, "zoom", zoomed_out, zoom_out_speed_sec)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.make_current()
func _process(delta):
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_path_following:
		path_follower.progress_ratio += 0.02
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "zoom", default_zoom, zoom_in_speed_sec)
		
		if path_follower.progress_ratio >= 1:
			player_cam.make_current()
			player.set_physics_process(true)
			is_path_following = false
		
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
		


func _on_transition_body_entered(body: Node2D) -> void:
	is_path_following = true
	player.set_physics_process(false)


func _on_transition_to_lvl_3_body_entered(body: Node2D) -> void:
	call_deferred("load_lvl3")

func load_lvl3():
	get_tree().change_scene_to_file('res://scenes/level3.tscn')
