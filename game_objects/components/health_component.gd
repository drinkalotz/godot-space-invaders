extends Node
class_name HealthComponent
@export var max_health: float = 100
var current_health: float
signal die()

func _ready() -> void:
	current_health = max_health

func take_damage(damage: float):
	current_health = max(current_health - damage, 0)
	if current_health == 0:
		die.emit()
