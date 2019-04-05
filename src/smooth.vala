double[] smooth_forward_ema(double rate, double[] data) {
    double[] res = new double[data.length];
    double val = data[0];
    for (int i = 0; i < data.length; ++i) {
        val += (1 - rate) * (data[i] - val);
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

double[] smooth_bidir_ema(double rate, double[] data) {
    double[] forward = smooth_forward_ema(rate, data);
    double[] backward = smooth_forward_ema(rate, reverse_doubles(data));
    for (int i = 0; i < data.length; ++i) {
        forward[i] += backward[data.length - (i + 1)];
        forward[i] /= 2;
    }
    return forward;
}
