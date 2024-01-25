package;

class Main {
	inline static var beatSeconds = 86.4;

	static function main() {
		final args = Sys.args();
		
		try {
			if (args[1].toLowerCase() == "--help") {
				help();
				return;
			}
		} catch (_) {}

		var date: Date = Date.now();
		if (args.length >= 1) {
			try {
				date = Date.fromString(args[1]);
			} catch (_) {
				Sys.println('swatch: unrecognized argument');
				help();
			}
		}

		// Display
		if (date != null) {
			Sys.println(getSwatch(date));
		}
	}

	static function help(): Void {
		var buf = new StringBuf();
		buf.add("swatch - converts time to swatch internet time\n");
		buf.add("usage: swatch [time]\n");
		buf.add("Time parameter can be emitted for current time. It can be formatted as:\n");
		buf.add("	- \"YYYY-MM-DD hh:mm:ss\"\n");
		buf.add("	- \"YYYY-MM-DD\"\n");
		buf.add("	- \"hh:mm:ss\"");
		Sys.println(buf.toString());
	}

	/**
	 * Converts Date -> Swatch
	 */
	public static function getSwatch(date: Date) {
		final hours = date.getUTCHours() + 1 % 24;
		final minutes = date.getUTCMinutes();
		final seconds = date.getUTCSeconds();
		final amountOfSeconds = (hours * 60 + minutes) * 60 + seconds;

		return round(amountOfSeconds / beatSeconds, 2);
	}

	/**
	 * Rounds to a specific decimal precision, borrowed from THX
	 */
	static function round(number: Float, precision: Int): Float {
		number *= Math.pow(10, precision);
		return Math.round(number) / Math.pow(10, precision);
	}
}
