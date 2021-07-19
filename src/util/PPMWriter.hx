package util;


import haxe.io.Bytes;
final toChar = String.fromCharCode;

class PPMWriter {
	var width: UInt;
	var height: UInt;
	var data: Bytes;
	var pos: UInt;

	public function new(width: UInt, height: UInt) {
		this.width = width;
		this.height = height;
		this.pos = 0;
		this.data = Bytes.alloc(width*height*3);
	}

	public function writeColor(r: UInt, g: UInt, b: UInt) {
		// Note to self, Bytes starts at index 1 rather than 0.
		this.data.set(pos++, r);
		this.data.set(pos++, g);
		this.data.set(pos++, b);
	}

	public function export(path:String) {
		var header = 'P6\n$width $height\n255\n';
		#if cpp
			var writer = sys.io.File.write(path, true);
			writer.writeString(header);
			writer.write(this.data);
			writer.close();
		#end
		#if lua
			sf.library.File.write(untyped path, '$header${this.data.toString()}');
		#end
	}
}