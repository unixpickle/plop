public int main(string[] args) {
    double smooth = 0.0;
    string title = "";
    bool compact = false;
    var entry = OptionEntry();
    entry.long_name = "smooth";
    entry.short_name = 's';
    entry.flags = 0;
    entry.arg = OptionArg.DOUBLE;
    entry.arg_data = &smooth;
    entry.description = "smoothing value";
    entry.arg_description = "DOUBLE";
    OptionEntry[] options = {entry};
    entry = OptionEntry();
    entry.long_name = "title";
    entry.short_name = 't';
    entry.flags = 0;
    entry.arg = OptionArg.STRING;
    entry.arg_data = &title;
    entry.description = "window title";
    entry.arg_description = "STRING";
    options += entry;
    entry = OptionEntry();
    entry.long_name = "compact";
    entry.short_name = 'c';
    entry.flags = 0;
    entry.arg = OptionArg.NONE;
    entry.arg_data = &compact;
    entry.description = "tight axis bounds";
    entry.arg_description = "BOOL";
    options += entry;

    try {
        var opt_ctx = new OptionContext("plop");
        opt_ctx.set_help_enabled(true);
        opt_ctx.add_main_entries(options, null);
        opt_ctx.parse(ref args);
    } catch (OptionError e) {
        stderr.printf("%s\n", e.message);
        return 1;
    }

    Gtk.init(ref args);
    double[] numbers = {};
    while (true) {
        string? line = stdin.read_line();
        if (line == null) {
            break;
        }
        double number = double.parse(line.strip());
        numbers += number;
    }
    if (numbers.length < 2) {
        stderr.printf("error: need at least 2 datapoints.\n");
        return 1;
    }
    var window = new LineGraph(numbers, compact);
    window.smoothing = smooth;
    if (title.length > 0) {
        window.title = title;
    }
    window.show_all();
    window.destroy.connect(Gtk.main_quit);
    Gtk.main();
    return 0;
}