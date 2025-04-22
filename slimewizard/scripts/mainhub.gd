extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var weapon: Control = $Player/Weapon
@onready var level1 = preload("res://scenes/levels/level_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon.queue_free()
	player.activate_mainhub_controls()
	var level_counter = 1
	for door in $Levels.get_children():
		door.get_child(2).text += var_to_str(level_counter)
		level_counter += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		for door in $Levels.get_children():
			if door.get_player_in_door_frame():
				print_debug("We in the door frame and interactin")
				get_tree().change_scene_to_packed(level1)
