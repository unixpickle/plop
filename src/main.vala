public int main(string[] args) {
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
    var window = new LineGraph(numbers);
    window.show_all();
    Gtk.main();
    return 0;
}