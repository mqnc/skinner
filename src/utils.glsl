
varying vec3 vPosition_;
varying vec3 vNormal_;
varying vec2 vUv_;

const vec3 red   = vec3(1.0, 0.0, 0.0);
const vec3 green = vec3(0.0, 1.0, 0.0);
const vec3 blue  = vec3(0.0, 0.0, 1.0);
const vec3 white = vec3(1.0, 1.0, 1.0);

float fractalNoise(vec3 xyz){
	float f = 1.0;
	const int n = 12;
	float q = 0.0;
	for(int i = 0; i<n; i++){
		q = q + (cnoise(xyz * f * vec3(1.0, 1.0, 1.0)) + 0.5) / f;
		f = f*2.0;
	}
	return q/2.0;
}

/*
//https://github.com/mrdoob/three.js/blob/dev/src/renderers/shaders/ShaderChunk/bumpmap_pars_fragment.glsl.js
vec2 dHdxy_fwd(float scale) {
	vec2 dSTdx = dFdx( vUv );
	vec2 dSTdy = dFdy( vUv );
	float Hll = scale * texture2D( bumpMap, vUv ).x;
	float dBx = scale * texture2D( bumpMap, vUv + dSTdx ).x - Hll;
	float dBy = scale * texture2D( bumpMap, vUv + dSTdy ).x - Hll;
	return vec2( dBx, dBy );
}
vec3 perturbNormalArb( vec3 surf_pos, vec3 surf_norm, float scale ) {
	vec2 dHdxy = dHdxy_fwd(scale);
	// Workaround for Adreno 3XX dFd*( vec3 ) bug. See #9988
	vec3 vSigmaX = vec3( dFdx( surf_pos.x ), dFdx( surf_pos.y ), dFdx( surf_pos.z ) );
	vec3 vSigmaY = vec3( dFdy( surf_pos.x ), dFdy( surf_pos.y ), dFdy( surf_pos.z ) );
	vec3 vN = surf_norm;		// normalized
	vec3 R1 = cross( vSigmaY, vN );
	vec3 R2 = cross( vN, vSigmaX );
	float fDet = dot( vSigmaX, R1 );
	fDet *= ( float( gl_FrontFacing ) * 2.0 - 1.0 );
	vec3 vGrad = sign( fDet ) * ( dHdxy.x * R1 + dHdxy.y * R2 );
	return normalize( abs( fDet ) * surf_norm - vGrad );
}
*/

vec3 tangent(vec3 n){
	if(abs(n.x) < abs(n.y)){
		return normalize(cross(n, vec3(1.0, 0.0, 0.0)));
	}
	else{
		return normalize(cross(n, vec3(0.0, 1.0, 0.0)));
	}
}

#ifdef DIFFUSE
	#define TVALUE vec3
#endif

#ifdef NORMAL_BUMP
	#define TVALUE vec4
#endif

#ifdef SPECULAR
	#define TVALUE float
#endif

#ifdef EMISSIVE
	#define TVALUE vec3
#endif
