shader_type spatial;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 screen_color = textureLod(screen_texture, SCREEN_UV, 1.0);
	if (screen_color.b >= 0.05){
		vec3 new_color = vec3(0.0);
		ALBEDO = new_color;
	}
	else{
		ALPHA = 0.0;
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
