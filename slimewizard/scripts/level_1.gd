# This is the first level of Slime Wizard.
# It has more basic math problem's to solve
# so the player gets used to the mathy
# mechanics

extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var weapon: Control = $Player/Weapon
@onready var starting_point: Marker2D = $StartingPoint

# Preload the enemy assets and the
# screen that gets displayed when 
# the player loses
@onready var basic_enemy_scene = preload("res://scenes/enemy.tscn")
@onready var level_over_screen = preload("res://scenes/level_over.tscn")
@onready var flying_eyball_scene = preload("res://scenes/flying_eyeball.tscn")

# Counter for all the enemies killed i.e.
# the player's points 
var enemies_killed = 0

# Used to offset assets from the center
const LEVEL_OVER_SCREEN_OFFSET = Vector2(230, -130)
const ENEMY_POSITION_OFFSET = 500
const SKY_OFFSET = -100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_speed(50)
	weapon.attack.connect(_on_weapon_attack_made)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# This teleporter will be left out in the future to
# implement procedurally generated level.
# The edge of the level. When reached, the player is teleported
# back to the start
func _on_teleporter_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print_debug("World edge found. Teleporting back...")
		player.position = starting_point.position

# Spawns a basic enemy
func _on_basic_enemy_spawner_timer_timeout() -> void:
	print_debug("BasicEnemySpawnerTimer timeout")
	# Makes an instance of the preloaded enemy scene
	var basic_enemy_instance = basic_enemy_scene.instantiate()
	
	# The position is the same as the player's y, but
	# the x is offsetted so it spawns 
	# outside of the camera's view
	basic_enemy_instance.set_position(
		Vector2(player.position.x + ENEMY_POSITION_OFFSET, 
				player.position.y))
	
	# Signal is emitted when
	# the enemy and player are touching 
	basic_enemy_instance.player_touched.connect(_on_enemy_touches_player)
	$Enemies.add_child(basic_enemy_instance)

# Lowers player's health. If 
# health is zero or lower,
# calls level_over()
func _on_enemy_touches_player():
	print_debug("Enemy touched player")
	player.lower_health()
	print_debug("Player health now: ", player.get_health())
	if player.get_health() <= 0:
		level_over()
	
# Displays how many enemies were killed.
# Then loads up the mainhub
func level_over():
	var mainhub = load("res://scenes/levels/mainhub.tscn")
	var level_over_screen_instance = level_over_screen.instantiate()
	level_over_screen_instance.get_child(0).get_child(0). \
		get_child(1).text += var_to_str(enemies_killed)
								
	level_over_screen_instance.position += LEVEL_OVER_SCREEN_OFFSET
	$Player.add_child(level_over_screen_instance)
	$Player.stop_speed()
	await get_tree().create_timer(2).timeout
	print_debug("Enemies killed: ", enemies_killed)
	get_tree().change_scene_to_packed(mainhub)

# Spawns a flying eyeball enemy. 
# Offsetted y so the enemy is in the sky
# Offsetted x to spawn outside of camera
func _on_flying_eyeball_spawner_timer_timeout() -> void:
	print_debug("FlyingEyeballSpawnerTimer timeout")
	var flying_eyeball_instance = flying_eyball_scene.instantiate()
	flying_eyeball_instance.set_position(
		Vector2(player.position.x + ENEMY_POSITION_OFFSET, 
				player.position.y + SKY_OFFSET))
	$Enemies.add_child(flying_eyeball_instance)

# Goes through all enemies and checks if
# the solution to their math problem is
# the same weapon's attack_value.
# Amount of enemies is raised by one
func _on_weapon_attack_made(attack_value):
	for enemy in $Enemies.get_children():
		if enemy.get_solution() == attack_value:
			print_debug("Enemy has been hit")
			enemy.death()
			enemies_killed += 1
