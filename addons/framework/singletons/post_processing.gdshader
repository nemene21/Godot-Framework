shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_nearest;
uniform vec4 vignette_color : source_color;
uniform sampler2D vignette_noise : repeat_enable;
uniform float vignette_noisiness : hint_range(0.0, 0.1);
uniform float vignette_noise_warp_speed : hint_range(0.0, 3.0, 0.1);
uniform vec2 centre = vec2(.5, .5);
uniform float distance_pow : hint_range(1.0, 5.0, 0.1);
uniform float distance_multiplyer : hint_range(0.0, 4.0, 0.1);
uniform float chromatic_abberation : hint_range(.0, 1.0);
uniform vec2 res = vec2(320, 180);

uniform float warp : hint_range(-10.0, 10.0, 0.1);

vec4 lerp(vec4 a, vec4 b, float c) {
	return a + (b - a) * c;
}

void fragment() {
	
	vec2 dc = abs(0.5-UV);
    dc *= dc;
	
	vec2 uv = UV;
	uv.x -= 0.5; uv.x *= 1.0+(dc.y*(0.3*warp)); uv.x += 0.5;
    uv.y -= 0.5; uv.y *= 1.0+(dc.x*(0.4*warp)); uv.y += 0.5;
	
	vec2 noise_offset = (texture(vignette_noise, UV + TIME * vignette_noise_warp_speed).rg * 2.0 - 1.0) * vignette_noisiness;
	float dist = distance(UV + noise_offset, centre);
	dist = pow(dist, distance_pow) * distance_multiplyer;
	
	float chromatic_dist = distance(uv, centre) * 2.0;
	chromatic_dist = pow(chromatic_dist, 3.0) * chromatic_abberation;
	
	// Get on screen pixel color (pixel.r and pixel.b are offset due to chromatic abberation)
	vec2 snap = 1.0 / res;
	vec2 snapped_uv = floor(uv / snap) * snap;
	vec4 pixel = vec4(
		texture(screen_texture, snapped_uv + 0.005 * chromatic_dist).r,
		texture(screen_texture, snapped_uv).g,
		texture(screen_texture, snapped_uv - 0.005 * chromatic_dist).b,
		1.0
	);
	
	// Cut out edges from the crt warping
	float mask = 1.0 - float(uv.x < .0 ||uv.x > 1.0 || uv.y < .0 || uv.y > 1.0);

	COLOR = vec4(lerp(pixel, vignette_color, dist).rgb * mask, 1.0);
}
