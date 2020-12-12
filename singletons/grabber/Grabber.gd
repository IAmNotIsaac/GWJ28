extends Area2D



var held_item : ItemInterface
var selected_item : ItemInterface



func _process(_delta) -> void:
	global_position = get_global_mouse_position()



func _input(event) -> void:
	# Grab item
	if event.is_action_pressed("grab_item"):
		var closest_body : ItemInterface
		var closest_distance : int = 4926
		
		for body in get_overlapping_bodies():
			if body is ItemInterface:
				if body.position.distance_to(get_global_mouse_position()) < closest_distance:
					closest_body = body
					closest_distance = body.position.distance_to(get_global_mouse_position())
		
		if closest_body != null:
			closest_body.z_index = 1
			closest_body.set_collision(ItemInterface.CollisionMode.HOLD)
			closest_body.follow_mouse = true
			closest_body.disable_glow()
			held_item = closest_body
	
	# Release item
	if event.is_action_released("grab_item") && held_item != null:
		held_item.z_index = 0
		held_item.set_collision(ItemInterface.CollisionMode.DEFAULT)
		held_item.follow_mouse = false
		held_item.velocity /= 10.0
		held_item = null
	
	# Fuse item
	if event.is_action_pressed("fuse_item") && held_item != null:
		var closest_body : ItemInterface
		var closest_distance : int = 4926
		
		for body in get_overlapping_bodies():
			if body is ItemInterface:
				if body.position.distance_to(get_global_mouse_position()) < closest_distance && body != held_item:
					closest_body = body
					closest_distance = body.position.distance_to(get_global_mouse_position())
		
		if closest_body != null:
			for i in closest_body.items.keys():
				held_item.add_item(Item.new(i.data))
			closest_body.queue_free()
			held_item.disable_glow()
