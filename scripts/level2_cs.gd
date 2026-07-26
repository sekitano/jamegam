extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var magic_blanket: Node2D = $magic_blanket
@onready var blanket_follow: Label = $Path2D/PathFollow2D/Camera2D/blanket_follow

#@onready var blanket_follow: Label = $Player/Camera2D/blanket_follow
@onready var camera: Camera2D = $Path2D/PathFollow2D/Camera2D
@onready var path_follower: PathFollow2D = $Path2D/PathFollow2D

const FOLLOW_SPEED = 4.0
const DISTANCE = 15.0

var default_zoom := Vector2(0.6, 0.6)
var zoomed_out := Vector2(1.15, 1.15)
#var zoom_in_speed_sec := 0.01
var zoom_out_speed_sec := 1

var is_path_following = false

#var tween = get_tree().create_tween()
#tween.tween_property(camera, "zoom", zoomed_out, zoom_out_speed_sec)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.play("gameplay")
	
	player.set_physics_process(false)
	player.animated_sprite.play("idle")
	is_path_following = true

func _process(delta):
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_path_following:
		path_follower.progress_ratio += 0.0051
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "zoom", zoomed_out, zoom_out_speed_sec)
		if path_follower.progress_ratio >= 1:
			is_path_following = false
			get_tree().change_scene_to_file('res://scenes/level2.tscn')
			#player.set_physics_process(true)
			
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
		
