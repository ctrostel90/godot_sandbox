shader_type spatial;

uniform bool highlight = false;
uniform vec3 highlight_color: source_color = vec3(0,1.0,0);
uniform vec3 non_highlight_color: source_color = vec3(0,1.0,0);

uniform float brightness: hint_range(0.1, 4.0, 0.1) = 3;

void fragment() {
	if(highlight){
		ALBEDO = highlight_color * brightness;	
	}else{
		ALBEDO = non_highlight_color * brightness;
	}
}
