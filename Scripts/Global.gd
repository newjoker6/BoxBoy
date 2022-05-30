extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	move_files()


func move_files():
	var dir = Directory.new()
	if dir.open("user://") == OK:
		dir.copy("res://spikesBlood.png", 'user://spikesBlood.png')
		dir.copy("res://Textures/spinbladeBlood3.png", 'user://spinbladeBlood3.png')
		dir.copy("res://Textures/spinbladeBlood2.png", 'user://sspinbladeBlood2.png')
		dir.copy("res://Textures/spinbladeBlood1.png", 'user://spinbladeBlood1.png')
