// Object class. This is what all other objects will inherit from
package struct;

class Object {
    public static var objects: Array<Object>;
    var pos: Vec3;
    var color: Vec3;

    // Create the object list
    public static function init() {
        Object.objects = [];
        PointLight.lights = [];
    }

    public static function get_all() {
        return objects;
    }

    function new(pos: Vec3, ?color: Vec3) {
        this.pos = pos;
        if (color != null) {
            this.color = color;
        }else {
            this.color = vec3(1, 0, 0);
        }
        objects.push(this);
    }

    public function intersect(ray: util.Ray, t_min: Float, t_max: Float) {
        return null;
    }
}