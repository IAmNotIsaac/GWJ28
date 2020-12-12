extends Area2D



var mouse_in_area := false

signal mouse_entered_area
signal mouse_left_area



func set_extents(new_extents : Vector2) -> void:
	$CollisionShape2D.shape.extents = new_extents



func is_mouse_in_area() -> bool:
	return mouse_in_area



func _on_MouseArea_mouse_entered():
	mouse_in_area = true
	emit_signal("mouse_entered_area")



func _on_MouseArea_mouse_exited():
	mouse_in_area = false
	emit_signal("mouse_left_area")
