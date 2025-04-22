extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var weapon: Control = $Player/Weapon
@onready var starting_point: Marker2D = $StartingPoint
@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var level_over_screen = preload("res://scenes/level_over.tscn")
var enemies_killed = 0
const LEVEL_OVER_SCREEN_OFFSET = Vector2(230, -130)
const ENEMY_POSITION_OFFSET = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_speed(50)
	weapon.value_changed.connect(_on_weapon_value_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_teleporter_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print_debug("World edge found. Teleporting back...")
		player.position = starting_point.position

func _on_enemy_spawner_timer_timeout() -> void:
	print_debug("EnemySpawnerTimer timeout")
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.set_position(
		Vector2(player.position.x + ENEMY_POSITION_OFFSET, 
				player.position.y))
	enemy_instance.player_touched.connect(_on_enemy_touches_player)
	$Enemies.add_child(enemy_instance)
	
func _on_weapon_value_changed(value):
	for enemy in $Enemies.get_children():
		if enemy.get_result() == value:
			print_debug("Enemy has been hit")
			enemy.death()
			enemies_killed += 1

func _on_enemy_touches_player():
	print_debug("Initiate Level 1 ending")
	level_over()

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
