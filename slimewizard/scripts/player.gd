extends CharacterBody2D

var SPEED = 150.0
const JUMP_VELOCITY = -200.0
var is_in_the_mainhub = false

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

func activate_mainhub_controls() -> void:
	is_in_the_mainhub = true

func set_speed(new_speed: int) -> void:
	SPEED = new_speed

func stop_speed():
	SPEED = 0
	$AnimatedSprite2D.stop()
