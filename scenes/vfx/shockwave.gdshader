shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_enable, filter_nearest;
uniform float animation : hint_range(0.0, 1.0);
uniform vec4  color : source_color;

const vec2 centre = vec2(0.5, 0.5);

void fragment() {
	float dist = distance(UV, centre);
	COLOR = color * float(dist < 0.5 && dist > animation);
}
