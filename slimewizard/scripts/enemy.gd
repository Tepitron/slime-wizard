# The Slime Wizard's basic enemies. 
# This could be turned into a base class
# in the future, if more enemies are needed

# The enemy has a math problem above it. 
# Solving the math problem kills the enemy
# Now implemented are addition and subtraction
# Coming in the future are multiplication and division


extends Area2D

@onready var label: Label = $Label

# Emitted when the enemy's and the player's hitboxes
# align
signal player_touched
# This is the solution to the
# math problem
var solution = 0

# These values are used to
# limit the ranges of the numbers
# in the math problem
var MIN_RANDOMIZER = 1
var MAX_RANDOMIZER = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Randomize the math problem's values
	var num1 = randi_range(MIN_RANDOMIZER,MAX_RANDOMIZER)
	var num2 = randi_range(MIN_RANDOMIZER,MAX_RANDOMIZER)
	
	# Randomizes the operation. 
	# 1 is addition
	# 2 is subtraction
	var operation = randi_range(1,2)
	
	# Addition
	if operation == 1:
		solution = num1 + num2
		label.text = var_to_str(num1) + "+" + \
					var_to_str(num2)
	# Subtraction
	elif operation == 2:
		solution = num1 - num2
		label.text = var_to_str(num1) + "-" + \
					var_to_str(num2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Called when the enemy dies. 
# Hides the math problem, plays the death animation
# and starts a death_timer. When the timer timesout
# the enemy is freed from queue
func death():
	print_debug("Enemy killed")
	$AnimatedSprite2D.play("death")
	$Label.hide()
	$DeathTimer.start()

# Returns the math problem's solution
func get_solution() -> int:
	return solution

# Destroys the enemy
func _on_death_timer_timeout() -> void:
	queue_free()

# Emits a signal to tell the level
# that the player's and the enemy's hitboxes
# are atop eachother.
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_touched.emit()

# Setter for randomizing the math problem's values.
func set_randomizer_min_max(min,max):
	MIN_RANDOMIZER = min
	MAX_RANDOMIZER = max
