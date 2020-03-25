clear;
clc;

x = [1:1:20]'; % transpose => column vector
window = ones(6, 1) * 2; % column vector
frame_size = length(window);
frame_shift = 3;
fft_size = 8;
fs = 2;
mode = 1;

spectrogram(x, window, frame_size, frame_shift, fft_size, fs);
