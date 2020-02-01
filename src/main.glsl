
void main(){

	#ifdef DIFFUSE
		gl_FragColor = vec4(value(vPosition_, vNormal_, vUv_), 1.0);
	#endif

	#ifdef NORMAL_BUMP
		vec4 n0_h0 = value(vPosition_, vNormal_, vUv_);
		vec3 n0 = n0_h0.xyz;
		vec3 tx = tangent(n0);
		vec3 ty = cross(n0, tx);

		const float d = 1e-5;
		float h0 = n0_h0.w;
		float dhdx = (value(vPosition_ + d*tx, vNormal_, vUv_).w-h0)/d;
		float dhdy = (value(vPosition_ + d*ty, vNormal_, vUv_).w-h0)/d;

		vec3 n_final = normalize(n0 - dhdx*tx - dhdy*ty);

		gl_FragColor = vec4(n_final*0.5 + 0.5, 1.0);

	#endif

	#ifdef SPECULAR
		gl_FragColor = vec4(value(vPosition_, vNormal_, vUv_) * vec3(1.0, 1.0, 1.0), 1.0);
	#endif

	#ifdef EMISSIVE
		gl_FragColor = vec4(value(vPosition_, vNormal_, vUv_), 1.0);
	#endif
}
