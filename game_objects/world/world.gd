extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var player_scene: PackedScene = preload("res://game_objects/player/player.tscn")
@onready var enemy_scene: PackedScene = preload("res://game_objects/enemy/enemy.tscn")
var first_wave = [[1,0,1,0,1], [0,1,0,1,0], [1,0,1,0,1], [0,1,0,1,0], [1,0,1,0,1]]
var second_wave = [[1,0,1,0,1,0,1,0,1,0,1], [0,0,0,1,0,1,0,1,0,0,0], [1,0,1,0,1,0,1,0,1,0,1], [0,0,0,1,0,1,0,1,0,0,0], [1,0,1,0,1,0,1,0,1,0,1]]
@onready var enemy_spawn: Marker2D = $EnemySpawn

func _ready():
	var player_instance = player_scene.instantiate()
	player_instance.global_position = player_spawn.global_position
	get_parent().add_child.call_deferred((player_instance))
	create_enemy_wave(second_wave)
			


func _on_top_boundry_area_area_entered(area: Area2D) -> void:
	var entity = area.get_parent()
	if entity.is_in_group("player_bullet"):
		entity.queue_free()


func create_enemy_wave(enemies):
	for i in range(enemies.size()):
		for j in range(enemies[i].size()):
			if enemies[i][j] == 1:
				var new_enemy = enemy_scene.instantiate()
				var new_position = Vector2(
					enemy_spawn.global_position.x + (j * 66), 
					enemy_spawn.global_position.y + (i * 46) 
				)
				new_enemy.global_position = new_position
				get_parent().add_child.call_deferred(new_enemy)
