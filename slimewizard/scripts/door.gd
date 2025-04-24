# The doors are used as warps to 
# levels from the mainhub.
# If the player is in front of a door,
# the player can interact with the door to 
# go to the designated level.
# The door has a label
# to identify which level it leads to.

extends Node2D

# Used to check if player is in front of 
# the door
var player_in_door_frame = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
# Checks if player is in front of door.
# If so, the flag variable is turned into true
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print_debug("Player in door range")
		player_in_door_frame = true
		
# Checks if player leaves from the door's area
# If so, turns the flag variable into false
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print_debug("Player left door range")
		player_in_door_frame = false
		
# Returns the flag variable. Is true
# if player is still in front of door.
# The flag is checked in the mainhub's script
# which handles player's interaction input.
func get_player_in_door_frame():
	return player_in_door_frame
