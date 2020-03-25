[x, fs] = audioread('../audio files/piano.wav');
soundsc(x, fs);
frame = x(10001:20001);
Frame = fft([frame;zeros(50000-length(frame),1)]); % assume LA is periodic -> mistakes <> calc speed
figure;
plot([0:length(Frame)-1]/length(Frame)*fs, 20*log10(abs(Frame)));
axis([0 2000 -45 60]);
