# This is the player character's weapon. Attacks are made when
# the weapon's numbers are the same as an enemy's math
# problem's result.

# Checks inputs ranging from 0 to 9. Corresponding number is shown
# as a string in the $Weapon/Label
# If the player inputs a minus, the attack value
# will be negative.
# If Enter is pressed, the attack is made (emits a signal),
# and the string of inputted numbers gets resetted

extends Control
signal attack(value: int)
var inputted_numbers = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("zero"):
		add_to_inputted_numbers(0)
	elif Input.is_action_just_pressed("one"):
		add_to_inputted_numbers(1)
	elif Input.is_action_just_pressed("two"):
		add_to_inputted_numbers(2)
	elif Input.is_action_just_pressed("three"):
		add_to_inputted_numbers(3)
	elif Input.is_action_just_pressed("four"):
		add_to_inputted_numbers(4)
	elif Input.is_action_just_pressed("five"):
		add_to_inputted_numbers(5)
	elif Input.is_action_just_pressed("six"):
		add_to_inputted_numbers(6)
	elif Input.is_action_just_pressed("seven"):
		add_to_inputted_numbers(7)
	elif Input.is_action_just_pressed("eight"):
		add_to_inputted_numbers(8)
	elif Input.is_action_just_pressed("nine"):
		add_to_inputted_numbers(9)
	elif Input.is_action_just_pressed("minus"):
		inputted_numbers = "-"
		$Label.text = inputted_numbers
	elif Input.is_action_just_pressed("enter"):
		attack.emit(get_result())
		reset_inputs()
		
# The parameter number is converted to a string.
# Then it's appended to inputted_numbers and finally 
# inputted_numbers is shown in the Label.
# Called from the _process()
func add_to_inputted_numbers(number):
	inputted_numbers += var_to_str(number)
	$Label.text = inputted_numbers

# Returns the inputted_numbers as an int.
# Used by level's to compare weapon's attack to
# the enemies' math problems
func get_result():
	print_debug(inputted_numbers)
	return inputted_numbers.to_int()

# Called when the player presses enter. 
# Inputted_numbers is resetted
# and the empty string is shown in
# Label. Replaces anything that was in
# Label beforehand.
func reset_inputs():
	inputted_numbers = ""
	$Label.text = inputted_numbers
