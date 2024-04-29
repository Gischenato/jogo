extends CharacterBody2D


const SPEED = 175.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation := $animation as AnimatedSprite2D

var can_jump = 0
var is_jumping := false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		can_jump += 1
	else:
		is_jumping = false
		can_jump = 0
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and can_jump < 6:
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	print(direction)
	if direction != 0:
		velocity.x = direction * SPEED
		animation.play('run')
		animation.scale.x = direction
		if is_jumping:
			animation.play('jump')
	else:
		animation.play('idle')	
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
