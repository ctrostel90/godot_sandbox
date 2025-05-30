shader_type spatial;

uniform vec2 highlight = vec2(6,6);
uniform vec3 highlight_color: source_color = vec3(0,1.0,0);

uniform vec2 resolution = vec2(600.0,400.0);
uniform vec3 line_color: source_color = vec3(0.2,0.3,0.5);
uniform float zoom: hint_range(1.0, 50.0, 0.1) = 20;
uniform float thickness: hint_range(0.1, 10.0, 0.1) = 2;
uniform float brightness: hint_range(0.1, 4.0, 0.1) = 3;

float draw_grid (vec2 uv){
	vec2 grid_uv = cos(uv * TAU);
	return max(grid_uv.x,grid_uv.y);
}

void fragment() {
	vec2 uv = UV - 0.5;
	uv.x *= resolution.x / resolution.y;

	vec2 grid_coord = floor((uv + 0.5) * zoom); // which grid square we're in
	vec2 highlight_coord = highlight;

	float line_thickness = zoom * thickness / resolution.y;

	// Draw grid color
	vec3 color = smoothstep(1.0 - line_thickness, 1.0, draw_grid(uv * zoom)) * line_color;

	// If we're in the highlighted grid cell, override with highlight_color
	if (grid_coord == highlight_coord) {
		color = highlight_color;
	}

	ALBEDO = color * brightness;
}