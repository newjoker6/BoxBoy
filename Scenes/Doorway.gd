extends Sprite


var next_lavel = false
var world 

# Called when the node enters the scene tree for the first time.
func _ready():
	world = get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if next_lavel == true and Input.is_action_just_pressed("Up"):
		world.next_level()


func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		next_lavel = true
		$Label.visible = true
