# Flying Eyeball is an enemy
# that will have harder math problem's
# but yields more points

# Flies over the player so failure to kill
# it won't hurt the player.

# In the future this will be derived from the baseclass Enemy
# to allow for a more flexible design

extends AnimatableBody2D

var solution
const SPEED = 70
@onready var solution_label: Label = $Solution

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var num1 = randi_range(15,150)
	var num2 = randi_range(15,150)
	solution = num1 + num2
	solution_label.text = var_to_str(num1) + "+" + var_to_str(num2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_left(delta)

func death():
	print_debug("Flying Eyeball killed")
	$DeathTimer.start(0.2)
	$AnimatedSprite2D.play("death")
	$Solution.hide()

func get_solution() -> int:
	return solution

func _on_death_timer_timeout() -> void:
	print_debug("Flying Eyeball death timer timedout")
	queue_free()
	
func move_left(delta: float) -> void:
	position.x -= SPEED * delta
