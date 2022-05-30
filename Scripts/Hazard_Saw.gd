extends Sprite

var variants = [
	"res://Textures/spinbladeBlood1.png",
	"res://Textures/spinbladeBlood2.png",
	"res://Textures/spinbladeBlood3.png"
]

var bloody
var selection

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$AnimationPlayer.play("Rotate")
	selection = variants[round(rand_range(0, variants.size() - 1))]



func _on_SawArea_body_entered(body):
	if "Player" == body.name:
		body.death()
		create_blood(selection)
		self.texture = bloody

func create_blood(image):
	var img = Image.new()
	img.load(image)
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	bloody = tex
