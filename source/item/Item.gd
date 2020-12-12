extends Node2D
class_name Item



enum Items { STICK, STONE }

var data : Dictionary



func _init(data_sample : Dictionary) -> void:
	data = data_sample
