extends Node2D

var current_level = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func next_level():
	current_level += 1
	print("res://Scenes/Level%s.tscn" %current_level)
	if current_level<4:
		var level = load("res://Scenes/Level%s.tscn" %current_level)
		var level_inst = level.instance()
		get_node("Level%s" %str(current_level -1)).queue_free()
		add_child(level_inst)
		$Player.spawn()
	else:
		get_tree().change_scene("res://Scenes/End.tscn")

