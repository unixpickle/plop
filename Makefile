build/plop: src/main.vala src/line_graph.vala src/y_labels.vala src/smooth.vala
	mkdir -p build
	valac --pkg gtk+-3.0 --pkg posix --target-glib=2.32 -X -lm src/*.vala -o build/plop

clean:
	rm -rf build
