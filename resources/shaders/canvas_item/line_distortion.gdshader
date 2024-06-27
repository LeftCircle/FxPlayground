shader_type canvas_item;

uniform sampler2D image;
uniform float time;

void fragment() {
    vec4 color = texture(image, FRAGCOORD.xy / SCREEN_PIXEL_SIZE);

    float lineThickness = 0.05;
    float noise = sin(FRAGCOORD.y * 100.0 + time * 5.0) * 0.02;
    float pattern = mod(FRAGCOORD.x / SCREEN_PIXEL_SIZE.x + noise, lineThickness);

    float mask = step(pattern, 0.01); // Adjust the threshold for thicker/thinner lines

    vec4 lineColor = vec4(0.0, 0.0, 0.0, 1.0); // Black lines
    COLOR = mix(color, lineColor, mask);
}
