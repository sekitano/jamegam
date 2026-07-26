extends Area2D

@onready var pickup_trash: AudioStreamPlayer = $PickupTrash
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	pickup_trash.play()
	animated_sprite_2d.hide()
	print("+1 trash")
	
	Global.cig_count += 1
	Global.trash_count += 1
	
	print("Total trash:", Global.trash_count)
	await pickup_trash.finished
	queue_free()
