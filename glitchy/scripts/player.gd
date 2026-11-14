extends CharacterBody2D

const JUMP_VELOCITY = -600.0
const DASH_MULTIPLIER = 5.0

var run_speed: float = 600.0
var acceleration: float = 7500.0
var braking: float = 10000.0

@onready var dash_length: Timer = $DashLenght
@onready var dash_cooldown: Timer = $DashCD
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var player: CharacterBody2D = $"."
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var current_movement_animation: String = ""

#dash function
func dash():
	dash_length.start()
	dash_cooldown.start()

#glitch (world change) function
func glitch():
	if manager.current_world == manager.world.city:
		player.set_collision_mask_value(2, true)
		player.set_collision_mask_value(1, false)
		manager.current_world = manager.world.nature
	elif manager.current_world == manager.world.nature:
		player.set_collision_mask_value(1, true)
		player.set_collision_mask_value(2, false)
		manager.current_world = manager.world.city
func _physics_process(delta: float) -> void:
	var was_on_floor = is_on_floor()
	var direction := Input.get_axis("move_right", "move_left")

# add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

# handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or !coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY

# flip sprite depending on direction
	if direction != 0.0:
		animation.flip_h = direction < 0.0

	
	if Input.is_action_just_pressed("dash") and dash_cooldown.is_stopped():
		dash()
		
		
	if Input.is_action_just_pressed("glitch"):
		glitch()


	update_horizontal_movement(direction, delta)
	move_and_slide()
	update_animation()

	if was_on_floor && !is_on_floor():
		coyote_timer.start()

#update the horizontal movement based on input and dash
func update_horizontal_movement(direction: float, delta: float) -> void:
	if not dash_length.is_stopped():
		velocity.x = direction * run_speed * DASH_MULTIPLIER
		return

	# drop back to regular speed as soon as the dash ends.
	velocity.x = clampf(velocity.x, -run_speed, run_speed)

	var target_speed := direction * run_speed
	var rate := braking if direction == 0.0 else acceleration
	velocity.x = move_toward(velocity.x, target_speed, rate * delta)

#update the animation based on the player's state
func update_animation() -> void:
    var next_animation: String = "idle"

    if not is_on_floor():
        next_animation = "jump"
    elif absf(velocity.x) > 1.0:
        next_animation = "move"

    if next_animation != current_movement_animation:
        animation.play(next_animation)
        current_movement_animation = next_animation
