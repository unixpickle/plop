double[] smooth_bidir_ema(double rate, double[] data) {
    double[] weights1 = forward_decayed_weights(rate, data.length);
    double[] weights2 = reverse_doubles(weights1);
    double[] values1 = forward_decayed_sum(rate, data);
    double[] values2 = reverse_doubles(forward_decayed_sum(rate, reverse_doubles(data)));
    for (int i = 0; i < data.length; ++i) {
        values1[i] = (values1[i] + values2[i]) / (weights1[i] + weights2[i]);
    }
    return values1;
}

double[] forward_decayed_sum(double rate, double[] data) {
    double[] res = new double[data.length];
    double val = 0;
    for (int i = 0; i < data.length; ++i) {
        val = val * rate + data[i];
        res[i] = val;
    }
    return res;
}

double[] forward_decayed_weights(double rate, int count) {
    double[] res = new double[count];
    double val = 0;
    for (int i = 0; i < count; ++i) {
        val = val * rate + 1;
        res[i] = val;
    }
    return res;
}

double[] reverse_doubles(double[] data) {
    double[] res = new double[data.length];
    for (int i = 0; i < data.length; ++i) {
        res[i] = data[data.length - (i + 1)];
    }
    return res;
}

