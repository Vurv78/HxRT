import util.PPMWriter;
import util.Ray;

using Safety;

final CONFIGS = CompileTime.parseJsonFile("configs.json");

private final WIDTH = CONFIGS.width;
private final HEIGHT = CONFIGS.height;
private final OUT_PATH = CONFIGS.out;
private final SAMPLES_PP = CONFIGS.spp;
private final MAX_DEPTH = CONFIGS.depth; // How many recursions to do max.

private final LOW_LEFT = vec3(-2, -1, -1);
private final HORIZONTAL = vec3(4, 0, 0);
private final VERTICAL = vec3(0, 2, 0);
private final CAM_POS = vec3(0, 0, 0);

function random_in_unit_sphere() {
	while (true) {
		var rand = vec3( randomFloat(-1, 1), randomFloat(-1, 1), randomFloat(-1, 1) );
		if (length_squared( rand ) >= 1) continue;
		return rand;
	}
}

function getColor(ray: Ray, ?depth_level: Int = 0) {
	var dir = ray.direction;
	var data = ray.intersect();
	if (data != null) {
		#if usenormals
			var normal = data.normal;
			return (vec3(1, 1, 1) + normal) * 0.5;
		#else
			if (depth_level > MAX_DEPTH)
				return vec3(0, 0, 0);

			var target = data.pos + data.normal + random_in_unit_sphere();
			var out = 0.5 * getColor( new Ray(data.pos, target - data.pos), depth_level+1 );
			return out;
			//var gamma_scale = 1 / SAMPLES_PP;
			//return (out*gamma_scale).sqrt(); // Gamma corrected color
		#end
	} else {
		// Hit nothing. Show sky gradient
		return sky( dir );
	}
}

function mainThread() {
	var writer = new PPMWriter(WIDTH, HEIGHT);
	var bench = Sys.time();
	var J = HEIGHT-1;
	while( J >= 0 ) {
		#if lua
			setName('${J/HEIGHT}%');
		#end
		for ( I in 0...WIDTH ) {
			var hit_col = vec3(0, 0, 0);

			for ( _ in 0...SAMPLES_PP ) {
				var u = (I + randomFloat(0, 1)) / (WIDTH-1);
				var v = (J + randomFloat(0, 1)) / (HEIGHT-1);
				var ray = new Ray( CAM_POS, (LOW_LEFT + u*HORIZONTAL + v*VERTICAL).normalize() );

				hit_col += getColor( ray ) * (255 / SAMPLES_PP);
			}

			writer.writeColor(
				Std.int( hit_col[0] ),
				Std.int( hit_col[1] ),
				Std.int( hit_col[2] )
			);
		}
		J--;
	}
	writer.export(OUT_PATH);
	Sys.println('Finished in ${Sys.time()-bench} seconds!');
	Sys.sleep(5);
}

function main() {
	struct.Object.init();
	new struct.Sphere( vec3(0, 0, -1), 0.5 );
	new struct.Sphere( vec3(0, -100.5, -1), 100, vec3(0, 0, 1) );

	mainThread();
}