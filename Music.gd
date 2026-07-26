extends Node

@onready var player: AudioStreamPlayer = $AudioStreamPlayer

var current_track:= ""

const TRACKS := {
	"menu": preload("res://assets/8. Frostbound Path.wav"),
	"opening_cs": preload("res://assets/1. Dawn of Blades.wav"),
	"gameplay": preload("res://assets/13. The Forgotten Grove.wav"),
	"ending_cs": preload("res://assets/6. Moonlit Vale.wav"),
}

func _ready():
	player.bus = "music"

func play(track_name: String):
	if current_track == track_name and player.playing:
		return
	
	current_track = track_name
	player.stream = TRACKS[track_name]
	player.play()
