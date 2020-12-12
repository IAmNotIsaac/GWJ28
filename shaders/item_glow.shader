shader_type canvas_item;

uniform bool active = false;



void fragment() {
	if (active) {
		vec4 color = texture(TEXTURE, UV);
		
		color.g = sin(TIME) / 2.0 + 1.0;
		
		COLOR = color;
	}
	
	else {
		COLOR = texture(TEXTURE, UV);
	}
}