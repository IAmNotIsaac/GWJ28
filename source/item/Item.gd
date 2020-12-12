extends RigidBody2D
class_name Item



enum Items { STICK, STONE }
enum CollisionMode { DEFAULT, HOLD }

var data : Dictionary

onready var sprite := $Sprite
onready var collision_shape := $CollisionShape2D
onready var mouse_grab_area := $MouseGrabArea
onready var mouse_grab_area_collision_shape := $MouseGrabArea/CollisionShape2D

var collision_shape_shape := RectangleShape2D.new()
var mouse_grab_area_shape := CircleShape2D.new()

var follow_mouse := false

export (Items) var item_override



func _ready() -> void:
	match item_override:
		Items.STICK: data = IDB.items.stick
		Items.STONE: data = IDB.items.stone
	
	sprite.texture = data.texture
	collision_shape_shape.extents = data.texture.get_size() / 2.0 * sprite.scale
	mouse_grab_area_shape.radius = max(data.texture.get_height(), data.texture.get_width()) / 2.0
	
	collision_shape.shape = collision_shape_shape
	mouse_grab_area_collision_shape.shape = mouse_grab_area_shape



func _physics_process(_delta) -> void:
	if follow_mouse:
		linear_velocity = (global_position - get_global_mouse_position()) * -1 * 25



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
