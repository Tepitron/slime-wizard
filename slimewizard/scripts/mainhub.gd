# MainHub of the game
# The mainhub will be filled with doors leading
# to levels. There will be signs explaining what
# category the level belongs to.
# Now implemented: Mathematics Level 1
#
# The player can move with left and right arrows
# and jump with the spacebar.
# Interacting with the doors happens
# with up arrowkey

extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var weapon: Control = $Player/Weapon
@onready var level1 = preload("res://scenes/levels/level_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Weapon is deleted from the player, because mainhub doesn't have
	# combat
	weapon.queue_free()
	# Mainhub controls 
	player.activate_mainhub_controls()
	
	# Displays level numbers on the doors
	var level_counter = 1
	for door in $Levels.get_children():
		door.get_child(2).text += var_to_str(level_counter)
		level_counter += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Interacting when in the hitbox of a door, lets you load
# the mentioned level
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		for door in $Levels.get_children():
			if door.get_player_in_door_frame():
				print_debug("We in the door frame and interactin")
				get_tree().change_scene_to_packed(level1)
