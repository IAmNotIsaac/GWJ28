extends Area2D



var selected_item : Item



func _process(_delta) -> void:
	global_position = get_global_mouse_position()



func _input(event) -> void:
	if event.is_action_pressed("grab_item"):
		for body in get_overlapping_bodies():
			if body is Item:
				body.set_collision(Item.CollisionMode.HOLD)
				body.follow_mouse = true
				selected_item = body
				break
	
	if event.is_action_released("grab_item") && selected_item != null:
		selected_item.set_collision(Item.CollisionMode.DEFAULT)
		selected_item.follow_mouse = false
		selected_item = null
