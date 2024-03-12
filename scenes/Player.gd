extends KinematicBody2D

export (int) var speed = 400
export (int) var GRAVITY = 1200
export (int) var jump_speed = -600

const UP = Vector2(0,-1)

var velocity = Vector2()
var is_first_jump = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	velocity.x = 0
	var animation = "idle"
	
	if velocity.y > 0 and not is_on_floor():
		animation = "falling"
		
	if velocity.y < 0:
		animation = "lompat"
		
		
		
	
	if is_on_floor() and Input.is_action_just_pressed('up'):
		velocity.y = jump_speed
		is_first_jump = true
	if not is_on_floor() and Input.is_action_just_pressed('up') and is_first_jump:
		velocity.y = jump_speed
		is_first_jump = false
	if Input.is_action_pressed('right'):
		velocity.x += speed
		$AnimatedSprite.flip_h = false
		if is_on_floor():
			animation = "jalan_kanan"
	if Input.is_action_pressed('left'):
		velocity.x -= speed
		$AnimatedSprite.flip_h = true
		if is_on_floor():
			
			animation = "jalan_kanan"
		
	if Input.is_action_pressed('down') and is_on_floor():
		velocity.x = velocity.x/2
		$crouchy.disabled = false
		$CollisionShape2D.disabled = true
		animation = "crouch"
		
	else:
		$crouchy.disabled = true
		$CollisionShape2D.disabled = false
		
	if Input.is_action_pressed("shoot"):
		animation = "shoot"
	
	if $AnimatedSprite.animation != animation:
		$AnimatedSprite.play(animation)

	
	
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
