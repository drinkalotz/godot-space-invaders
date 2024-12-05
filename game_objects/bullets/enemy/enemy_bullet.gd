extends StaticBody2D
class_name EnemyBullet
@export var max_speed = 600


func _process(delta: float) -> void:
	global_position.y += max_speed * delta


func delete_bullet():
	queue_free()
