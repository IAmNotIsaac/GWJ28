extends KinematicBody2D
class_name ItemInterface



const shader_load = preload("res://shaders/item_glow.shader")

enum DefaultItems { NONE, STICK, STONE }
enum CollisionMode { DEFAULT, HOLD }

onready var items := {}
onready var tween = $Tween

var follow_mouse := false
var last_attach_point := Vector2.ZERO
var velocity := Vector2.ZERO
var gravity := 0
var wasnt_on_floor := false

export (DefaultItems) var default_item : int = DefaultItems.NONE



func _ready() -> void:
	match default_item:
		DefaultItems.NONE: pass
		DefaultItems.STICK: add_item(Item.new(IDB.items.stick))
		DefaultItems.STONE: add_item(Item.new(IDB.items.stone))



func _physics_process(delta) -> void:
	if follow_mouse:
		velocity = (global_position - get_global_mouse_position()) * -1 * 25
	
	move_and_slide(velocity, Vector2.UP)
	
	velocity.y = min(velocity.y + gravity, 500)
	
	if is_on_floor():
		velocity.x = 0
		if wasnt_on_floor:
			event(IDB.Events.ON_LAND)
			wasnt_on_floor = false
	else:
		wasnt_on_floor = true
		velocity.x = lerp(velocity.x, 0, 0.02)
	
	if is_on_wall():
		velocity.x /= 2 * -1



func add_item(item : Item) -> void:
	var collision_shape = CollisionShape2D.new()
	var sprite = Sprite.new()
	var rect_shape = RectangleShape2D.new()
	var shader_material = ShaderMaterial.new()
	var mouse_area_collision_shape = CollisionShape2D.new()
	var mouse_area_shape = RectangleShape2D.new()
	var mouse_area = Area2D.new()
	
	
	shader_material.shader = shader_load
	rect_shape.extents = item.data.texture.get_size() / 2.0
	collision_shape.shape = rect_shape
	
	sprite.texture = item.data.texture
	sprite.material = shader_material
	
	mouse_area_shape.extents = item.data.texture.get_size() / 2.0
	mouse_area_collision_shape.shape = mouse_area_shape
	
	mouse_area.add_child(mouse_area_collision_shape)
	mouse_area.connect("area_entered", self, "area_entered")
	mouse_area.connect("area_exited", self, "area_exited")
	
	
	items[item] = {
		"collision_shape" : collision_shape,
		"mouse_area" : mouse_area,
		"sprite" : sprite
	}
	
	sprite.position = last_attach_point - item.data.anchor_point * min(len(items) - 1, 1)
	collision_shape.position = last_attach_point - item.data.anchor_point * min(len(items) - 1, 1)
	mouse_area.position = last_attach_point - item.data.anchor_point * min(len(items) - 1, 1)
	
	last_attach_point += item.data.attach_point
	gravity += item.data.gravity
	
	update_items()



func update_items() -> void:
	for item in items.values():
		if !item.sprite.is_inside_tree():
			add_child(item.sprite)
		
		if !item.collision_shape.is_inside_tree():
			add_child(item.collision_shape)
		
		if !item.mouse_area.is_inside_tree():
			add_child(item.mouse_area)



func set_collision(set_mode : int) -> void:
	for i in 20:
		set_collision_layer_bit(i, false)
		set_collision_mask_bit(i, false)
	
	match set_mode:
		CollisionMode.DEFAULT:
			set_collision_layer_bit(0, true)
			set_collision_mask_bit(0, true)
		
		CollisionMode.HOLD:
			set_collision_layer_bit(1, true)
			set_collision_mask_bit(1, true)
			set_collision_layer_bit(2, true)
			set_collision_mask_bit(2, true)



func enable_glow() -> void:
	for item in items.values():
		item.sprite.material.set_shader_param("active", true)



func disable_glow() -> void:
	for item in items.values():
		item.sprite.material.set_shader_param("active", false)



func is_object_in_area(object : Object) -> bool:
	for item in items.values():
		if object in item.mouse_area.get_overlapping_bodies() || object in item.mouse_area.get_overlapping_areas():
			return true
	return false



func area_entered(area : Area2D) -> void:
	if area.is_in_group("grabber"):
		if area.held_item != self:
			enable_glow()



func area_exited(area : Area2D) -> void:
	if area.is_in_group("grabber"):
		if is_object_in_area(area):
			disable_glow()



func _input(event) -> void:
	if event.is_action_pressed("utilise"):
		event(IDB.Events.ON_UTILISE)



func event(event : int) -> void:
	for i in len(items):
		var item = items.keys()[i]
		
		for event_check in item.data.properties:
			if event == event_check:
				for result_check in item.data.properties.get(event_check):
					var result = result_check
					
					for condition in item.data.properties.get(event_check).get(result_check):
						if condition(condition, {"index": i}):
							result(result)



func condition(condition : int, args := {}) -> bool:
	match condition:
		IDB.Conditions.NONE : return true
		IDB.Conditions.IF_BASE : if args.index == 0: return true
		IDB.Conditions.IF_HELD : if follow_mouse: return true
		_ : print("Unexpected condition: %s" % [condition])
	
	return false



func result(result : int) -> void:
	match result:
		IDB.Results.DO_SWING: pass
		IDB.Results.DO_STOMP: pass
