shader_type spatial;

uniform vec2 highlight = vec2(0,0);
uniform vec3 highlight_color: source_color = vec3(0,1.0,0);

void fragment() {
	// Called for every pixel the material is visible on.
	
	if (int(UV.x*100.0) % 2 == 0 && int(UV.y*100.0) % 2 == 0){
		ALBEDO = vec3(1,0,0);
	}
}
