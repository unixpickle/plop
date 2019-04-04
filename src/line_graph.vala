using Gtk;

class LineGraph : Window {
    private static int PADDING = 5;

    private DrawingArea drawing_area;

    private double[] data;
    private double y_min;
    private double y_max;

    public double smoothing = 0.0;

    public LineGraph(double[] numbers) {
        this.data = numbers;
        this.find_min_max();
        this.setup_drawing_area();
    }

    public void redraw() {
        this.drawing_area.queue_draw();
    }

    private void find_min_max() {
        double min = data[0];
        double max = data[0];
        foreach (double x in data) {
            if (x < min) {
                min = x;
            }
            if (x > max) {
                max = x;
            }
        }

        this.y_min = 0.0;
        this.y_max = 0.0;

        bool found_min = (this.y_min <= min);
        bool found_max = (this.y_max >= max);

        if (found_min && found_max) {
            this.y_max = 1.0;
            return;
        }

        for (int power = -8; power < 32; ++power) {
            for (int i = 1; i < 10; ++i) {
                double bound = (double)i * Math.pow(10.0, (double)power);
                if ((bound >= max || found_max) && (-bound <= min || found_min)) {
                    if (!found_max) {
                        this.y_max = bound;
                    }
                    if (!found_min) {
                        this.y_min = -bound;
                    }
                    return;
                }
            }
        }

        this.y_max = 1.0;
    }

    private void setup_drawing_area() {
        this.drawing_area = new DrawingArea();
        this.add(drawing_area);
        this.drawing_area.draw.connect((ctx) => {
            ctx.set_source_rgba(1.0, 1.0, 1.0, 1.0);
            ctx.paint();

            double[] x;
            double[] y;
            this.get_points(out x, out y);

            ctx.save();
            ctx.set_source_rgba(1.0, 0, 0, 1.0);
            ctx.move_to(x[0], y[0]);
            for (int i = 1; i < x.length; ++i) {
                ctx.line_to(x[i], y[i]);
            }
            ctx.stroke();
            ctx.restore();

            return true;
        });
    }

    private void get_points(out double[] x, out double[] y) {
        x = new double[this.data.length];
        y = new double[this.data.length];
        int width = this.drawing_area.get_allocated_width() - PADDING * 2;
        int height = this.drawing_area.get_allocated_height() - PADDING * 2;
        double datum = this.data[0];
        for (int i = 0; i < this.data.length; ++i) {
            datum += (1 - this.smoothing) * (this.data[i] - datum);
            x[i] = i * (double)width / (double)(this.data.length - 1);
            y[i] = (datum - this.y_min) / (this.y_max - this.y_min);
            y[i] *= (double)height;
            y[i] = (double)height - y[i];
            x[i] += (double)PADDING;
            y[i] += (double)PADDING;
        }
    }
}