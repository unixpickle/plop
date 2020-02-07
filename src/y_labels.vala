using Gtk;

class YLabels : Grid {

    public YLabels(double min, double max) {
        this.orientation = Orientation.VERTICAL;
        this.vexpand = true;

        // Cast to float to reduce decimal places.
        var max_label = new Label(@"$((float)max)");
        max_label.vexpand = true;
        max_label.valign = Align.START;
        this.add(max_label);

        // Cast to float to reduce decimal places.
        var min_label = new Label(@"$((float)min)");
        min_label.vexpand = true;
        min_label.valign = Align.END;
        this.add(min_label);
    }

}
