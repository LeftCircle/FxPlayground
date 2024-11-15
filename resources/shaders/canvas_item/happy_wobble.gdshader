shader_type canvas_item;

uniform float wobble_amount = 30.0;
uniform float jump_height = 50.0;
uniform float wobble_speed = 6.0;
uniform float jump_speed = 4.0;
uniform float squash_stretch_scale : hint_range(0.0, 3.0, 0.1) = 1.0;
uniform float squash_scale : hint_range(0.0, 3.0, 0.1) = 1.0;
uniform float stretch_scale : hint_range(0.0, 3.0, 0.1) = 1.0;


void vertex() {
	// jump
	float pos_cos = (cos(jump_speed * TIME) + 1.0) / 2.0;
	VERTEX.y -= jump_height * pos_cos * pos_cos;
	float jump_mask = smoothstep(0.0, 1.0, cos(jump_speed * TIME));
	
	// side to side wiggle
	float height = 1.0 / TEXTURE_PIXEL_SIZE.y;
	float scaled_height = VERTEX.y / height;
	float wobble = wobble_amount * sin(wobble_speed * TIME) * scaled_height;
	
	
	// A wobble mask so the image only wiggles in the air
	wobble *= jump_mask;
	VERTEX.x += wobble;
	
	// Squash and stretch
	float squash_stretch = (squash_stretch_scale * (cos(jump_speed * TIME) + 1.0) / 2.0 + 0.5);
	VERTEX.y *= 1.0 * squash_stretch;
	VERTEX.x *= 1.0 / squash_stretch;
}

void fragment() {
	// Called for every pixel the material is visible on.
	//COLOR.x = VERTEX.x;
	//COLOR.y = VERTEX.y;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
