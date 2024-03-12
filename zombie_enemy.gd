extends KinematicBody2D

export (int) var speed = 100
export (int) var GRAVITY = 1200

const UP = Vector2(0,-1)

var velocity = Vector2()
var flipped = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = speed
	$AnimatedSprite.play("move")
	


func _physics_process(delta):
	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity, UP)
	if is_on_wall():
		print("bonk")
		if not flipped:
			velocity.x = -speed
			$AnimatedSprite.flip_h = true
			flipped = true
		else:
			velocity.x = speed
			$AnimatedSprite.flip_h = false
			flipped = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
		
