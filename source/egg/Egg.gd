extends Node2D
class_name Egg



onready var crack_sample = $Crack
onready var crack_area = $CrackArea

var cracks := []



func _ready() -> void:
	WorldEvents.connect("item_thwap", self, "thwapped")



func create_crack(set_position : Vector2) -> void:
	var crack = crack_sample.duplicate()
	crack.visible = true
	crack.position = set_position
	add_child(crack)
	cracks.append(crack)



func thwapped(item : Dictionary) -> void:
	for area in crack_area.get_overlapping_areas():
		if area.is_in_group("grabber"):
			var cancel := false
			
			for crack in cracks:
				if crack.position.distance_to(item.sprite.global_position) < 45:
					cancel = true
					crack.scale = Vector2(min(crack.scale.x + 0.2, 2), min(crack.scale.y + 0.2, 2))
					break
			
			if !cancel:
				create_crack(item.sprite.global_position)
			
			break
