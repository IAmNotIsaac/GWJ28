extends Node2D



onready var particle_presets := {
	"Thwap" : {
		"node" : $Thwap,
		"leeway" : 2
	},
	
	"FlameBurst" : {
		"node" : $FlameBurst,
		"leeway" : 2
	}
}



func play_particles(preset : String, set_position := Vector2.ZERO) -> void:
	if preset in particle_presets:
		var particles = particle_presets[preset].node.duplicate()
		particles.emitting = true
		particles.visible = true
		add_child(particles)
		particles.position = set_position
		
		if particles.one_shot:
			var timer = Timer.new()
			add_child(timer)
			timer.wait_time = particles.lifetime + particle_presets[preset].leeway
			timer.start()
			
			yield(timer, "timeout")
			
			timer.queue_free()
			particles.queue_free()
	
	else:
		print("Particle preset not found: %s." % [preset])



func _ready() -> void:
	for preset in particle_presets.values():
		preset.emitting = false
		preset.visible = false
