extends Area2D

var trash_count = 0
var cig_count = 0
var bottle_count = 0
var broken_bottle_count = 0
var can_count = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered_can(body: Node2D) -> void:
	print("+1 trash")
	print(body.name)
	can_count += 1
	trash_count += 1
	print("total trash: ", trash_count)
	print(can_count)
	queue_free()


func _on_body_entered_cig(body: Node2D) -> void:
	print("+1 trash")
	print(body.name)
	cig_count +=1
	trash_count += 1
	print("total trash: ", trash_count)
	print(trash_count)
	print(cig_count)
	queue_free()

func _on_body_entered_bottle(body: Node2D) -> void:
	print("+1 trash")
	print(body.name)
	bottle_count += 1
	trash_count += 1
	print("total trash: ", trash_count)
	print(trash_count)
	print(bottle_count)
	queue_free()

func _on_body_entered_broken_bottle(body: Node2D) -> void:
	print("+1 trash")
	print(body.name)
	broken_bottle_count += 1
	trash_count += 1
	print("total trash: ", trash_count)
	print(trash_count)
	print(broken_bottle_count)
	queue_free()
	
#func add_score_cig():
#	cig_count += 1
	
#func add_score_bottle():
#	bottle_count += 1
	
#func add_score_broken_bottle():
#	broken_bottle_count += 1

#func add_score_can_count():
#	can_count += 1
	
#func add_score():
#	trash_count += can_count 
#	trash_count += broken_bottle_count
#	trash_count += cig_count
#	trash_count += bottle_count
	
