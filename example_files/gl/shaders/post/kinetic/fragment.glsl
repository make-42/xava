#ifdef GL_ES
	precision mediump float;
#endif

varying vec2 v_texCoord;

uniform sampler2D s_texture;
uniform sampler2D s_depth;

uniform vec4 shadow_color;
uniform vec2 shadow_offset;

uniform vec4 bgcolor;

uniform float intensity;

// Credit: https://github.com/Jam3/glsl-fast-gaussian-blur/blob/master/5.glsl
vec4 blur5(sampler2D image, vec2 uv, vec2 resolution, vec2 direction) {
	vec4 color = vec4(0.0);
	vec2 off1 = vec2(1.3333333333333333) * direction;
	color += texture2D(image, uv) * 0.29411764705882354;
	color += texture2D(image, uv + (off1 / resolution)) * 0.35294117647058826;
	color += texture2D(image, uv - (off1 / resolution)) * 0.35294117647058826;
	return color;
}

void main() {
	vec4 depth = texture2D(s_depth, v_texCoord);

	// test if infinite
	if(depth.r == 1.0) {
		float depth = 1.0 - blur5(s_depth, shadow_offset+v_texCoord, vec2(2.0, 2.0), shadow_offset).r;
		depth *= 1.6; // strenghten shadows
		vec4 color = mix(bgcolor, shadow_color, depth);
		gl_FragColor = mix(color, vec4(0.0, 0.0, 0.0, 1.0), intensity);
	} else {
		gl_FragColor = texture2D(s_texture, v_texCoord);
	}
}

