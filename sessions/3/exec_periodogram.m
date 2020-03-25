clear;
clc;

x = [1:1:20]'; % transpose => column vector
window = ones(5, 1) * 2; % column vector
frame_size = length(window);
frame_shift = 4;
fft_size = 10;
fs = 2;
mode = 1;

periodogram(x, window, frame_size, frame_shift, fft_size, fs, mode);
