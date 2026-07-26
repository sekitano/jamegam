extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var magic_blanket: Node2D = $magic_blanket
@onready var blanket_follow: Label = $blanket_follow
@onready var path_follower: PathFollow2D = $Path2D/PathFollow2D
#@onready var camera: Camera2D = $Path2D/PathFollow2D/Camera2D3
@onready var camera: Camera2D = $Camera2D2
@onready var elevator: AnimationPlayer = $platform/AnimationPlayer
@onready var button_elevator: Area2D = $button_elevator
@onready var button_door: Area2D = $button_door
@onready var blanket_body = $magic_blanket/StaticBody2D
@onready var anim1: AnimatedSprite2D = $button_elevator/anim
@onready var anim2: AnimatedSprite2D = $button_door/anim
@onready var anim3: AnimatedSprite2D = $door_wall/anim


#@onready var blanket_follow: Label = $Player/Camera2D/blanket_follow

var default_zoom := Vector2(3.19, 3.19)
var zoomed_out := Vector2(1.15, 1.15)
var zoom_in_speed_sec := 0.3
var zoom_out_speed_sec := 1

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
		path_follower.progress_ratio += 0.0051
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "zoom", zoomed_out, zoom_out_speed_sec)
		if path_follower.progress_ratio >= 1:
			#get_tree().change_scene_to_file("res://scenes/level4.tscn")
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


func _on_killbrick_spikes_body_entered(body: Node2D) -> void:
	call_deferred("respawn")
func respawn():
	get_tree().change_scene_to_file("res://scenes/level4.tscn")


func _on_button_elevator_area_entered(area: Area2D) -> void:
		elevator.play("elevator")
		anim1.play("button_down")
		print("ENTER: ", area.name)
		print("TYPE: ", area.get_class())


func _on_button_elevator_area_exited(area: Area2D) -> void:
	elevator.pause()
	anim1.play("button_up")


func _on_button_door_area_entered(area: Area2D) -> void:
	anim2.play("button_down")
	anim3.play("open")
	get_node("door_wall/CollisionShape2D2").set_deferred("disabled", true)
	

func _on_button_door_area_exited(area: Area2D) -> void:
	anim2.play("button_up")
	anim3.play("close")
	get_node("door_wall/CollisionShape2D2").set_deferred("disabled", false)
