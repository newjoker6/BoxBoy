extends Sprite


var variants = [
	"user://spikesBlood.png"
]

var bloody
var selection


func _ready():
	randomize()
	selection = "user://spikesBlood.png"



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
