extends KinematicBody2D

export (int) var speed = 400
export (int) var GRAVITY = 1200
export (int) var jump_speed = -600

const UP = Vector2(0,-1)

var velocity = Vector2()
var is_first_jump = true

const DOUBLETAP_DELAY = .25
var doubletap_time = DOUBLETAP_DELAY
var last_keycode = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	velocity.x = 0
	if is_on_floor() and Input.is_action_just_pressed('up'):
		velocity.y = jump_speed
		is_first_jump = true
	if not is_on_floor() and Input.is_action_just_pressed('up') and is_first_jump:
		velocity.y = jump_speed
		is_first_jump = false
	if Input.is_action_pressed('right'):
		velocity.x += speed
		$Sprite.flip_h = false
	if Input.is_action_pressed('left'):
		velocity.x -= speed
		$Sprite.flip_h = true
		
	if Input.is_action_pressed('down'):
		velocity.x = velocity.x/2
		$crouchy.disabled = false
		$CollisionShape2D.disabled = true
		$Sprite.scale.y = 0.5
		$Sprite.offset.y = 55
		
	else:
		$crouchy.disabled = true
		$CollisionShape2D.disabled = false
		$Sprite.offset.y = 0
		$Sprite.scale.y = 1
	
		
func _input(event):
	if event is InputEventKey and event.is_pressed():
		if last_keycode == event.keycode and doubletap_time >= 0: 
			print("DOUBLETAP: ", event.keycode)
			last_keycode = 0
		else:
			last_keycode = event.keycode
		doubletap_time = DOUBLETAP_DELAY
	
	
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)


func _process(delta):
	doubletap_time -= delta


