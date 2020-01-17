
TVALUE value(vec3 vPosition, vec3 vNormal, vec2 vUv) {

	float grassNoise = fractalNoise(48.0*vPosition*vec3(1.0, 1.0, 2.0));
	float rockNoise = fractalNoise(4.0*vPosition);
	float snowNoise = fractalNoise(2.0*vPosition);
	float grassFrazzle = fractalNoise(2.0*vPosition*vec3(1.0, 1.0, 3.0)+4.0);

	float snowmask = smoothstep(0.0, 0.1, vPosition.z) * smoothstep(0.2, 0.6, (texture2D(snowmap, vUv).r*2.0-1.0) + 1.2*(snowNoise-0.5) );

	float grassmask = smoothstep(0.4, 0.6, 1.0*(texture2D(grassmap, vUv).r*2.0-1.0) + 1.5*(grassFrazzle-0.5) + (rockNoise-0.5));
	grassmask = grassmask * (1.0-snowmask);

	float rockmask = (1.0-snowmask-grassmask);

	#ifdef DIFFUSE // return a color as vec3
		vec3 grasscol = 0.5*green*(1.0-grassNoise) + vec3(0.3, 0.8, 0.0)*grassNoise;
		vec3 rockcol = 0.5*white;
		vec3 snowcol = white;
		return grassmask*grasscol + rockmask*rockcol + snowmask*snowcol;
	#endif
	#ifdef NORMAL_BUMP // return a vec4 with xyz being the surface normal and w being additional bump displacement
		float grassbump = 0.3 + 0.5*grassNoise;
		float rockbump = rockNoise;
		float snowbump = 0.7 + 0.3*snowNoise;
		return vec4(vNormal, (grassmask*grassbump + rockmask*rockbump + snowmask*snowbump)/16.0);
		//return vec4(vNormal, 0.0);
	#endif
	#ifdef SPECULAR // return a specular value as float
		return snowmask + grassNoise*grassmask;
	#endif
	#ifdef EMISSIVE // return a color as vec3
		return vec3(0.2, 0.3, 0.9)*snowmask + grassNoise*grassmask*green*0.1;
	#endif
}
