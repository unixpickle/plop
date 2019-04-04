public void main(string[] args) {
    Gtk.init(ref args);
    double[] numbers = {};
    while (true) {
        string? line = stdin.read_line();
        if (line == null) {
            break;
        }
        double number = double.parse(line);
        numbers += number;
    }
    var window = new LineGraph(numbers);
    window.show_all();
    Gtk.main();
}