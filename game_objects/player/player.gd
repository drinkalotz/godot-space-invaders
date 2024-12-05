extends StaticBody2D
@export var max_speed = 300
@onready var player_bullet_scene: PackedScene = preload("res://game_objects/bullets/player/player_bullet.tscn")
var bullet_on_cooldown = false
@onready var bullet_cooldown_timer: Timer = $BulletCooldownTimer

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and not bullet_on_cooldown:
		fire_bullet()
		bullet_on_cooldown = true
		bullet_cooldown_timer.start()
	var direction = Input.get_axis("ui_left", "ui_right")
	global_position.x += direction * max_speed * delta
	global_position.x = clamp(global_position.x, 20, get_viewport().size.x - 20)


func fire_bullet():
	var bullet_instance = player_bullet_scene.instantiate() as Node2D
	bullet_instance.global_position = global_position
	get_tree().root.add_child(bullet_instance)
	


func _on_bullet_cooldown_timer_timeout() -> void:
	bullet_on_cooldown = false
