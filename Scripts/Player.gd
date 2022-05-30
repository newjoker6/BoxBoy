extends KinematicBody2D


#-------Variables-----

var Acceleration = 25
var Max_Speed = 500
var Velocity = Vector2.ZERO
var Jump_Height = -550
var Friction = false
var Fall_Speed = 10

const Gravity = 20

var alive = true

#-------Onready Variables-----

onready var Player_Sprite = $AnimatedSprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	Friction = false
	input()
	move_and_slide(Velocity, Vector2.UP)


func input():
	
	if alive == true:
		#-------Movement-----
		
		if Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
			Velocity.x =  min(Velocity.x + Acceleration, Max_Speed)
			Player_Sprite.flip_h = false
			if is_on_floor():
				Player_Sprite.play("Run")
		elif Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
			Velocity.x = max(Velocity.x - Acceleration, -Max_Speed)
			Player_Sprite.flip_h = true
			if is_on_floor():
				Player_Sprite.play("Run")
		else:
			if is_on_floor():
				Player_Sprite.play("Idle")
			Friction = true
			Velocity.x = lerp(Velocity.x, 0, 0.1)
		
		
		#-------Jump-----
		
		if is_on_floor():
			if Input.is_action_just_pressed("Jump"):
				Player_Sprite.play("Jump")
				$JumpAudio.play()
				Velocity.y = Jump_Height
			if Friction == true:
				Velocity.x = lerp(Velocity.x, 0, 0.2)
		else:
			if Friction == true:
				Velocity.x = lerp(Velocity.x, 0, 0.05)
		
		
		#-------Wall Jump-----
		
		if not is_on_floor():
			if not is_on_wall():
				Player_Sprite.play("Fall")
				Velocity.y += Gravity
			if is_on_wall():
				if Player_Sprite.flip_h == true:
					Player_Sprite.flip_h = false
				elif Player_Sprite.flip_h == false:
					Player_Sprite.flip_h = true
				Player_Sprite.play("WallSlide")
				Velocity.y = lerp(Velocity.y, 0, 0.2)
				Velocity.y += Fall_Speed
				if Input.is_action_just_pressed("Jump") and Input.is_action_pressed("Right"):
					$JumpAudio.play()
					Velocity.y = Jump_Height
					Velocity.x = -Max_Speed
				if Input.is_action_just_pressed("Jump") and Input.is_action_pressed("Left"):
					$JumpAudio.play()
					Velocity.y = Jump_Height
					Velocity.x = Max_Speed
				if not Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
					if Player_Sprite.flip_h == true:
						Player_Sprite.flip_h = false
					elif Player_Sprite.flip_h == false:
						Player_Sprite.flip_h = true
					if Input.is_action_just_pressed("Jump") and Player_Sprite.flip_h == true:
						Velocity.y = Jump_Height
						Velocity.x = -Max_Speed
					if Input.is_action_just_pressed("Jump") and Player_Sprite.flip_h == false:
						Velocity.y = Jump_Height
						Velocity.x = Max_Speed



func death():
	alive = false
	$CollisionShape2D.disabled = true
	Player_Sprite.play("Death")
	Velocity = Vector2.ZERO
	$DeathAudio.play()
	yield(get_tree().create_timer(1),"timeout")
	spawn()

func spawn():
	self.position = get_parent().get_node("Level%s/SpawnPoint" % get_parent().current_level).position
	alive = true
	$CollisionShape2D.disabled = false


