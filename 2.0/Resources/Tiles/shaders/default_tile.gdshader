shader_type spatial;

uniform float moisture_level: hint_range(0, 1.0) = 1.0;
uniform vec3 dry_color: source_color;
uniform vec3 wet_color: source_color;

void fragment() {
    ALBEDO = mix(dry_color,wet_color,moisture_level);
}