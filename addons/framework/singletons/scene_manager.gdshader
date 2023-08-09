shader_type canvas_item;

uniform sampler2D transition_texture: repeat_enable;
uniform float animation: hint_range(0.0, 2.0);
uniform vec2  offset;
uniform vec2  res = vec2(320, 180);

void fragment() {
	float value = texture(transition_texture, floor(UV * res) / res + offset).r + animation - 1.0;
	float computed = float(value > 0.5);
	COLOR = vec4(0, 0, 0, clamp(computed, 0, 1));
}
