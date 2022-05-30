extends Sprite


var variants = [
	"res://spikesBlood.png"
]

var bloody
var selection


func _ready():
	randomize()
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
