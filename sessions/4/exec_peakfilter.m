clear;
clc;

% Audio signal (time domain)
[x, fs] = audioread("../../audio_files/Chichester3.wav");
xN = length(x);

% Audio signal (frequency domain)
Xd = fft(x); % discrete Fourier coefficients of audio signal
fFirst = 0; % first frequency in fundamental interval
fStep = fs/xN; % step size of frequency axis
fLast = (xN - 1) * fStep; % last frequency in fundamental interval
f = fFirst:fStep:fLast;

% Inputs
fc = 2000; % center frequency (Hz)
fb = 800; % frequency range (Hz) of -3dB points

% Magnitude Response with gain = 20
gain = 20;
[N, D] = peakfilter(gain, fc, fb, fs);
Fd = discrete_tf(f, fs, N, D);
Yd = Xd .* Fd;
plot_filter(f, Xd, Fd, Yd);


% Magnitude Response with gain = -20
gain = -20;
[N, D] = peakfilter(gain, fc, fb, fs);
Fd = discrete_tf(f, fs, N, D);
Yd = Xd .* Fd;
plot_filter(f, Xd, Fd, Yd);
