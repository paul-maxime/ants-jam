shader_type spatial;

uniform vec4 color : source_color = vec4(1.0);
uniform float alpha = 1.0;

void vertex() {
}

void fragment() {
	ALBEDO = color.rgb;
	ALPHA = alpha;
}
