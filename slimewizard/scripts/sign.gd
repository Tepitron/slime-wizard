extends Area2D

var is_player_in_range = false
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.hide()
	
func _process(_delta: float) -> void:
	if is_player_in_range:
		label.show()
	else:
		label.hide()
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print_debug("Player visited")
		is_player_in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print_debug("Player left :(")
		is_player_in_range = false
