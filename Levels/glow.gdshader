shader_type canvas_item;

// Control how bright the green parts glow
uniform float glow_intensity : hint_range(1.0, 30.0) = 8.0;

void fragment() {
	// 1. Get the normal color of the tile pixel
	vec4 base_color = texture(TEXTURE, UV);
	
	// 2. Check if the pixel is heavily green.
	// This math checks if Green is noticeably brighter than Red and Blue.
	// This prevents white, grey, or brown walls from accidentally glowing.
	if (base_color.g > base_color.r * 1.2 && base_color.g > base_color.b * 1.2) {
		// Multiply ONLY the green pixels by your intensity
		COLOR = vec4(base_color.rgb * glow_intensity, base_color.a);
	} else {
		// Leave all other blocks completely normal
		COLOR = base_color;
	}
}