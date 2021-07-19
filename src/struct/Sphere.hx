package struct;

class Sphere extends struct.Object {
    var radius: Float;

    public function new(pos, radius, ?color) {
        super(pos, color);
        this.radius = radius;
    }

    public override function intersect(ray: util.Ray, t_min: Float, t_max: Float) {
        var ray_origin = ray.pos;
        var ray_dir = ray.direction;

        var oc = ray_origin - (this.pos);
        var a = length_squared(ray_dir);
        var half_b = oc.dot(ray_dir);

        var c = length_squared(oc) - radius.pow(2);
        var discriminant = half_b.pow(2) - a * c;

        if (discriminant > 0) {
            var temp = (-half_b - Math.sqrt(discriminant) ) / a;
            var hit = false;
            if (temp < t_max && temp > t_min) {
                hit = true;
            } else {
                temp = (-half_b + Math.sqrt(discriminant) ) / a;
                if (temp < t_max && temp > t_min) {
                    hit = true;
                }
            }
            if (hit) {
                var hit_pos = ray.point_at_range(temp);
                return {
                    t: temp,
                    pos: hit_pos,
                    normal: ( hit_pos - (this.pos) ) / this.radius
                }
            }
        }
        // Didn't hit
        return null;
    }
}