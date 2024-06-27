shader_type spatial;

uniform sampler2D source_image;
uniform vec2 image_size;
uniform float time;

void fragment() {
    vec2 uv = FRAGCOORD.xy / image_size;

    // Parameters for the rectangles
    float rect_width = 0.01; // Adjust to change the width of the rectangles
    float rect_height = 0.1; // Adjust to change the height of the rectangles

    // Find the center of the rectangle that the current pixel belongs to
    float rect_center_x = floor(uv.x / rect_width) * rect_width + rect_width / 2.0;
    float rect_center_y = floor(uv.y / rect_height) * rect_height + rect_height / 2.0;

    // Sample the center color
    vec4 center_color = texture(source_image, vec2(rect_center_x, rect_center_y));

    // Compute blend factor from bottom to top of the rectangle
    float blend_factor = (uv.y - (floor(uv.y / rect_height) * rect_height)) / rect_height;

    // Blend from white to the center color
    vec4 blended_color = mix(vec4(1.0), center_color, blend_factor);

    // Output the final color
    ALBEDO = blended_color.rgb;
    ALPHA = blended_color.a;
}
