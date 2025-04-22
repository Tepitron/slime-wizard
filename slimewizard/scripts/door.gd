extends Node2D

var player_in_door_frame = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print_debug("Player in door range")
		player_in_door_frame = true
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print_debug("Player left door range")
		player_in_door_frame = false
		
func get_player_in_door_frame():
	return player_in_door_frame
