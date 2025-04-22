extends Area2D

@onready var label: Label = $Label
signal player_touched
var result = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var num1 = randi_range(1,10)
	var num2 = randi_range(1,10)
	result = num1 + num2
	
	label.text = var_to_str(num1) + "+" + var_to_str(num2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func death():
	print_debug("Enemy killed")
	$AnimatedSprite2D.play("death")
	$Label.hide()
	$Death_Timer.start()

func get_result() -> int:
	return result

func _on_death_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print_debug("Player touched enemy")
		player_touched.emit()
		
