# The player character called The Slime Wizard
# Can move in the mainhub with left and right
# arrow keys. Can jump with the spacebar.
# Can interact with doors.
# The mechanics change when loading into
# a level.

extends CharacterBody2D

var SPEED = 150.0
var HEALTH = 5
const JUMP_VELOCITY = -200.0
var is_in_the_mainhub = false

# Jumps and left right inputs
# are used when in the mainhub
# Otherwise the player
# moves always left
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_in_the_mainhub:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if direction == 1:
			$AnimatedSprite2D.flip_h = true
		elif direction == -1:
			$AnimatedSprite2D.flip_h = false
	
	else:
		velocity.x = SPEED
		
	move_and_slide()

# Used for activating controls
func activate_mainhub_controls() -> void:
	is_in_the_mainhub = true

# Setter for player's speed
func set_speed(new_speed: int) -> void:
	SPEED = new_speed

# Stop player from moving.
# Stops the animation
func stop_speed():
	SPEED = 0
	$AnimatedSprite2D.stop()

# Returns player's current health
func get_health():
	return HEALTH

# Setter for player's new health.
# Plays animation for
# different health amounts
func set_health(new_health: int):
	HEALTH = new_health
	
	if HEALTH == 5:
		$Health.play("five")
	elif HEALTH == 4:
		$Health.play("four")
	elif HEALTH == 3:
		$Health.play("three")
	elif HEALTH == 2:
		$Health.play("two")
	elif HEALTH == 1:
		$Health.play("one")
	else:
		print_debug("DEAD")

# Lower player's health by one. 
# Disables collision checking while iframes are active
func lower_health():
	set_health(HEALTH-1)
	$IFrames.start(2)
	$AnimatedSprite2D.play("hit")
	set_collision_layer_value(2, false)

# Activates collision when iframes timeout
func _on_i_frames_timeout() -> void:
	set_collision_layer_value(2, true)
	$AnimatedSprite2D.play("idle")
