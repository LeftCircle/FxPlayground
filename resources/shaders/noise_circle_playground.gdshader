shader_type canvas_item;

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

// My own port of this processing code by @beesandbombs
// https://dribbble.com/shots/1696376-Circle-wave


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
float shape(vec2 st, float radius) {
	st = vec2(0.5)-st;
    float r = length(st)*2.0;
    float a = atan(st.y,st.x);
    float m = abs(mod(a+TIME*2.,3.14*2.)-3.14)/3.6;
	m = abs(mod(a + TIME, PI * 2.0) - PI) / 30.6;
	//float m = 0.0;
    // Creates the circle! 1.-smoothstep(f,f+0.007,r);
	float f = radius;
    //m = noise(st+TIME*0.1)*.5;
    // a *= 1.+abs(atan(TIME*0.2))*.1;
    // a *= 1.+noise(st+TIME*0.1)*0.1;
    // sin(a*5.0) creates the flower shape
	// noise(st+TIME*.2)*.1 causes distortion
	//f += sin(a*5.0)*noise(st+TIME*.2)*.1;


	//f += (sin(a*10.0)*5.1*pow(m,2.));
    f += m;
	// adds the wiggle
	//f += 0.1 * pow(m, 1.0);


	return 1.-smoothstep(f,f+0.007,r);
}

float shapeBorder(vec2 st, float radius, float width) {
    return shape(st,radius)-shape(st,radius-width);
}


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 color = vec3(1.0) * shapeBorder(UV,0.5,0.1);

	COLOR = vec4( 1.-color, 1.0 );
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
