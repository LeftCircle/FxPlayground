shader_type canvas_item;

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

float shape(vec2 st, float radius, float t_offset, float freq_mod) {
	st = vec2(0.5)-st;
    float r = length(st)*2.0;
    //float a = atan(st.y,st.x);
	float a = asinh(st.y*TIME);
    float m = abs(mod(a + t_offset + TIME*2.,3.14*freq_mod)-3.14)/3.6;
    float f = radius;
    m += noise(st+TIME*0.1)*.5;
    // a *= 1.+abs(atan(u_time*0.2))*.1;
    // a *= 1.+noise(st+u_time*0.1)*0.1;
    f += sin(a*50.)*noise(st+TIME*.2)*.1;
    f += (sin(a*20.)*.1*pow(m,2.));
    return 1.-smoothstep(f,f+0.007,r);
}

float shapeBorder(vec2 st, float radius, float width, float t_offset, float freq_mod) {
    return shape(st,radius, t_offset, freq_mod) - shape(st, radius-width, t_offset, freq_mod);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// fmod of 0.5 creates 4 rotations which is pretty cool.
	vec3 color = vec3(1.0) * shapeBorder(UV, 0.8, 0.12, 0.0, 2.0);
	vec3 color_2 = vec3(1.0) * shapeBorder(UV, 0.45, 0.12, 3.14, 2.0);
	COLOR = vec4(1.0 - color - color_2, 1.0);
}
