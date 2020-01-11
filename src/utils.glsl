
varying vec3 vPosition;
varying vec3 vNormal;
varying vec2 vUv;

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
