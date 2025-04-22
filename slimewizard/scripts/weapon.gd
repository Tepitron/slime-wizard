extends Control
signal value_changed(value: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		$SpinBox.value += 1
	elif Input.is_action_just_pressed("down"):
		$SpinBox.value -= 1
		
func get_amount():
	return $SpinBox.value

func _on_spin_box_value_changed(value: float) -> void:
	value_changed.emit(value)
