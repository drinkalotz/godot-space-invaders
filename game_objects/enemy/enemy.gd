extends StaticBody2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var explosion_scene: PackedScene = preload("res://game_objects/components/bullet_particle_component.tscn")
@onready var enemy_bullet: PackedScene = preload("res://game_objects/bullets/enemy/enemy_bullet.tscn")
var local_explosion_instance = null
var movement_buffer = 0.0
var movement_threshold = 0.5
const MAX_SPEED = 100
@onready var timer: Timer = $Timer
@export var shoot_chance = 0.01

func _ready() -> void:
	GameManager.direction_changed.connect(on_direction_changed)
	health_component.die.connect(on_die)
	timer.start()


func _process(delta: float):
	global_position.x += delta * GameManager.direction * MAX_SPEED
	#movement_buffer += delta
	#if movement_buffer >= movement_threshold:
		#global_position.x += global_position.x + GameManager.direction * GameManager.x_offset
		#movement_buffer = 0.0

func on_die():
	var explosion_instance: CPUParticles2D = explosion_scene.instantiate()
	explosion_instance.global_position = global_position
	explosion_instance.emitting = true
	local_explosion_instance = explosion_instance
	explosion_instance.finished.connect(on_finished_particle)
	get_tree().root.add_child(explosion_instance)
	queue_free()


func _on_enemy_destroy_area_area_entered(area: Area2D) -> void:
	var entity = area.get_parent() as PlayerBullet
	if entity == null:
		entity = area
	if entity.is_in_group("player_bullet"):
		health_component.take_damage(1)
		entity.delete_bullet()
	elif entity.is_in_group("left_boundry"):
		GameManager.emit_direction_changed()
	elif entity.is_in_group("right_boundry"):
		GameManager.emit_direction_changed()



func on_finished_particle():
	if local_explosion_instance:
		local_explosion_instance.queue_free()
		
func on_direction_changed():
	global_position.y = global_position.y + GameManager.y_offset


func _on_timer_timeout() -> void:
	if randf() > shoot_chance:
		return
	var new_bullet = enemy_bullet.instantiate() as StaticBody2D
	new_bullet.global_position = global_position
	get_tree().root.add_child.call_deferred(new_bullet)
