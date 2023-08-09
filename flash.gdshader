shader_type canvas_item;

uniform float flash;
uniform vec3  flash_color: source_color = vec3(1, 1, 1);

void fragment() {
	vec4 pixel = texture(TEXTURE, UV);
	COLOR.rgb  = mix(pixel.rgb, flash_color, flash);
	COLOR.a = pixel.a;
}
