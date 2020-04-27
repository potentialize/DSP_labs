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
gains = [10 10 10 10 10]; 
fcs = [50 200 800 3200 12800];
% fbs = [10 10 10 10 10];
fbs = fcs;

% Validate input sizes
if (length(gains) ~= length(fcs) || length(fcs) ~= length(fbs))
  error('Input vectors gain, fcs and fbs have different sizes');
end

% Filter count
fCount = length(gains);

% Calculate filter(s)
Fds = ones(1, fCount);
for i = 1:fCount
  [N, D] = peakfilter(gains(i), fcs(i), fbs(i), fs);
  Fd = discrete_tf(f, fs, N, D);
  Fds = Fds .* Fd;
end

% Output
Yd = Xd .* Fd;
plot_filter(f, Xd, Fds, Yd);

% Play original synchronously
playblocking(audioplayer(x, fs));

pause(0.2); % s

% Play modified synchronously
y = real(ifft(Yd)); % imaginary part turned out 0
playblocking(audioplayer(y, fs));
