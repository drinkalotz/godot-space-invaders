extends Node
var direction = -1
var prev_direction = null
var x_offset = 33
var y_offset = 23
signal direction_changed(new_direction)

func _ready():
	prev_direction = direction * -1
func emit_direction_changed():
	if prev_direction == direction:
		return
	prev_direction = direction
	direction = direction * -1
	direction_changed.emit()
