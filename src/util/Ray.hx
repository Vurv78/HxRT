package util;

using VectorMath;
import struct.Object;
import haxe.ds.Option;

private final TMIN = 0;
private final TMAX = 2^53-1;

typedef IntersectData = {
	pos: Vec3,
	normal: Vec3,
	t: Float // Same as ray.t
}

class Ray {
	public var pos: Vec3;
	public var direction: Vec3;
	public var range: Float;

	public function new(pos: Vec3, dir: Vec3, range: Float = 2^53-1) {
		this.pos = pos;
		this.direction = dir;
		this.range = range;
	}

	// point_at_parameter
	public function point_at_range(range: Float): Vec3 {
		return (this.pos + this.direction * range);
	}

	function intersect_obj(obj: Object, t_min: Float, t_max: Float): Null<IntersectData> {
		return obj.intersect(this, t_min, t_max);
	}

	public function intersect(): Null<IntersectData> {
		for ( object in Object.get_all() ) {
			final result = this.intersect_obj(object, TMIN, TMAX);
			if(result != null) {
				// Hit, set it to the closest result.
				return result;
			}
		}
		return null;
	}
}