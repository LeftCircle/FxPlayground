shader_type spatial;

uniform vec3 color_1 : source_color= vec3(255,0,0);
uniform vec3 color_2 : source_color= vec3(0,255,0);
uniform vec3 color_3 : source_color= vec3(0,0,255);
uniform float spin_speed : hint_range(0.0, 1.0, 0.011) = 0.25;

vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

// Gradient Noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/XdXGW8
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

mat2 rotate2d(float _angle){
    return mat2(vec2(cos(_angle), sin(_angle)), vec2(-sin(_angle), cos(_angle)));
}
float shape(vec2 st, float radius, float t_offset, float freq_mod, float speed) {
	st = vec2(0.5)-st;
    float r = length(st)*2.0;
    float a = atan(st.y,st.x);
    //float m = abs(mod(a+TIME*2.,3.14*2.)-3.14)/3.6;
	float m = 0.0;
    // Creates the circle! 1.-smoothstep(f,f+0.007,r);
	float f = radius;
    m = noise(st+TIME*0.1)*.15;
    // a *= 1.+abs(atan(TIME*0.2))*.1;
    // a *= 1.+noise(st+TIME*0.1)*0.1;
    // sin(a*5.0) creates the flower shape
	// noise(st+TIME*.2)*.1 causes distortion
	//f += sin(a*5.0)*noise(st+TIME*.2)*.1;


	//f += (sin(a*10.0));//*.1*pow(m,2.));
    f += m;
	// adds the wiggle
	//f += 0.1 * pow(m, 1.0);
	return 1.-smoothstep(f,f+0.007,r);
}

float shapeBorder(vec2 st, float radius, float width, float t_offset, float freq_mod, float speed) {
    return shape(st,radius, t_offset, freq_mod, speed) - shape(st, radius-width, t_offset, freq_mod, speed);
}


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//vec3 color = vec3(1.0) * shapeBorder(UV,0.5,0.1);
//
	//COLOR = vec4( 1.-color, 1.0 );
	vec2 tr1 = 0.1 * vec2(noise(vec2(1.0) * TIME * 0.1), noise(vec2(1.0) * TIME * 0.1));
	tr1 = rotate2d(TIME * 0.1) * tr1;
	vec2 uv_1 = UV + tr1;
	vec2 uv_2 = UV + rotate2d(TIME * 0.2 + 4.0 * PI / 3.0) * tr1;
	vec2 uv_3 = UV + rotate2d(TIME * 0.3 + 2.0 * PI / 3.0) * tr1;

	vec2 r0 = rotate2d(-TIME * spin_speed) * (vec2(0.5) - uv_1) + vec2(0.5);
	vec2 r1 = rotate2d(TIME * spin_speed * 1.25) * (vec2(0.5) - uv_2) + vec2(0.5);
	vec2 r2 = rotate2d(TIME * spin_speed * 1.5) * (vec2(0.5) - uv_3) + vec2(0.5);
	vec4 ac1 = vec4(color_1, 0.333) * shapeBorder(r0, 0.8, 0.12, 0.0, 2.0, 0.25);
	vec4 ac2 = vec4(color_2, 0.333) * shapeBorder(r1, 0.8, 0.12, 4.0 * PI / 3.0, 2.0, 0.5);
	vec4 ac3 = vec4(color_3, 0.333) * shapeBorder(r2, 0.8, 0.12, 2.0 * PI / 3.0, 2.0, spin_speed * 0.75);
	COLOR = ac1 + ac2 + ac3;
	COLOR.a = clamp(COLOR.a, 0, 0.8);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
