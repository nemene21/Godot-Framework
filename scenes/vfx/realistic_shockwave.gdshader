shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest_mipmap_anisotropic;
uniform float strength;
uniform float thickness : hint_range(0.0, 1.0);

const vec2 CENTRE = vec2(.5, .5);

void fragment() {
	vec2 diff = UV - CENTRE;
	float dist = length(diff);
	vec2 dir = diff / dist;
	float mask = (1.0 - smoothstep(0.0, thickness, dist)) * smoothstep(0.0, thickness, dist);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - mask * strength * dir * 0.05);
}
