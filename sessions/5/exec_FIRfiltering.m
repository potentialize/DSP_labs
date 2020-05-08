signal = randn(1000000, 1);
fltr = randn(2000, 1);

[result_m, result_conv] = FIRfiltering(signal, fltr);
