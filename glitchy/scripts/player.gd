extends CharacterBody2D


var SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var dash_length: Timer = $dash_length
@onready var dash_cooldown: Timer = $dash_cooldown


func dash():
	dash_length.start()
	dash_cooldown.start()
	SPEED *= 10
func _on_dash_length_timeout() -> void:
	SPEED /=10


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_right", "move_left")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Handle dashing
	if Input.is_action_just_pressed("dash") and dash_cooldown.is_stopped():
		dash()

	move_and_slide()
