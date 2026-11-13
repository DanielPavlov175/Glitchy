extends CharacterBody2D


var SPEED = 600.0
const JUMP_VELOCITY = -600.0
@onready var dash_length: Timer = $dash_length
@onready var dash_cooldown: Timer = $dash_cooldown
@onready var player: CharacterBody2D = $"."
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D


# Dash function
func dash():
	dash_length.start()
	dash_cooldown.start()
	SPEED *= 5
func _on_dash_length_timeout() -> void:
	SPEED /= 5

# Glitch (world change) function
func glitch():
	if manager.current_world==manager.world.city:
		player.set_collision_mask_value(2,true)
		player.set_collision_mask_value(1,false)
		manager.current_world = manager.world.nature
	elif  manager.current_world==manager.world.nature:
		player.set_collision_mask_value(1,true)
		player.set_collision_mask_value(2,false)
		manager.current_world = manager.world.city
	


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_right", "move_left")
	
	# Flip sprite depending on direction
	if direction > 0:
		animation.flip_h = false
	elif direction < 0:
		animation.flip_h = true
		
	# Play idle, jump, moving animation
	# !!!!! DASH ANIMATION DOESNT WORK PLEASE FIX LATER
	if direction == 0 and is_on_floor():
		animation.play("idle")
	elif not is_on_floor():
		animation.play("jump")
	else:
		animation.play("move")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Handle dashing
	if Input.is_action_just_pressed("dash") and dash_cooldown.is_stopped():
		dash()
		
	# Handle glitching (changing worlds)
	if Input.is_action_just_pressed("glitch"):
		glitch()

	move_and_slide()
