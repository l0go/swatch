package;

class Main {
	inline static var beatSeconds = 86.4;

	static function main() {
		final args = Sys.args();
		final lastArg = args[args.length - 1] ?? "";
		
		var date: Date = Date.now();
		var splitter = ~/[:\s-]/g;

		switch (splitter.split(lastArg)) {
			case [""]: // skip if blank
			// For YYYY-MM-DD, hh:mm:ss, and YYYY-MM-DD hh:mm:ss
			case [_, _, _, _] | [_, _, _]:
				try {
					date = Date.fromString(lastArg);
				} catch (_) {
					Sys.stderr().writeString("swatch: unrecognized date string\n");
					help();
					return;
				}
			case ["--help"]:
				help();
				return;
			default:
				Sys.stderr().writeString("swatch: unrecognized argument\n");
				help();
				return;
		}

		// Display
		Sys.println(getSwatch(date));
	}

	static function help() {
		var buf = new StringBuf();
		buf.add("swatch - converts time to swatch internet time\n");
		buf.add("usage: swatch [time]\n");
		buf.add("Time parameter can be emitted for current time. It can be formatted as:\n");
		buf.add("	- \"YYYY-MM-DD hh:mm:ss\"\n");
		buf.add("	- \"YYYY-MM-DD\"\n");
		buf.add("	- \"hh:mm:ss\"\n");
		Sys.stderr().writeString(buf.toString());
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
