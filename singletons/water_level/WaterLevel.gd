extends Control



onready var texture := $TextureRect

var water_level := 0.0
var water_position_y := 0.0

const WATER_MAX := 100.0



func update_level() -> void:
	var percentage := clamp(water_level / WATER_MAX, 0.0, 1.0)
	var equation = percentage * 720
	
	texture.rect_position.y = 720 - equation
	water_position_y = equation



func set_water_level(new_value : float):
	water_level = clamp(new_value, 0.0, WATER_MAX)
	update_level()



func _ready() -> void:
	set_water_level(0)
