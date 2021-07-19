package struct;

class PointLight extends struct.Object {
    var brightness: Float;
    public static var lights: Array<PointLight>;

    public function new(pos, radius, brightness) {
        super(pos, radius);
        this.brightness = brightness;
    }

    public override function intersect(ray: util.Ray, t_min: Float, t_max: Float) {
        return null;
    }
}