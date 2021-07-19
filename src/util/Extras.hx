package util;
using VectorMath;

// This is a file that will provide compatibility between C++ and Lua functions as well as add some functionality to existing funcs

inline function length_squared( vec: Vec3 )
	return vec.x.pow(2) + vec.y.pow(2) + vec.z.pow(2);

inline function randomFloat(min: Float, max:Float): Float
	return Math.random()*(max-min) + min;

private final SKY_MIN = vec3(1.0, 1.0, 1.0);
private final SKY_MAX = vec3(0.5, 0.7, 1.0);

function sky(dir: Vec3) {
	var t = 0.5*(dir.normalize().y + 1);
	return (1.0-t) * SKY_MIN + t * SKY_MAX;
}