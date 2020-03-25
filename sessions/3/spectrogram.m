% [S,T,F]=spectgram(x,window,N,P,L,fs);
%
% Spectrogram calculation via the short-time Fourier transform
%
% INPUTS
%   x       : signal
%   window  : windowing function (vector of length N)
%   N       : frame length
%   P       : frame shift
%   L       : FFT size
%   fs      : sampling frequency
% OUTPUTS
%   S       : magnitude squared spectrograms
%   T       : corresponding time vector
%   F       : corresponding frequency vector


function [S,T,F] = spectrogram(x, window, frame_size, frame_shift, fft_size, fs)
  S = [];

  nyquist_frequency = fs / 2;

  first_sample_index = 1;
  last_sample_index = fft_size * nyquist_frequency;

  frame_count = 0;

  % NOTE: frame size may not land at length(x), in which case the last few
  %       elements are ignored
  for last_in_frame = frame_size:frame_shift:length(x)
      first_in_frame = last_in_frame - frame_size + 1;

      frame_count = frame_count + 1;

      % current frame
      frame = x(first_in_frame:last_in_frame,1); % column 1

      windowed_frame = frame .* window; % element wise multiplication

      % frequency response of current frame (windowed)
      XLr = fft(windowed_frame, fft_size); % NOTE: fft does padding by itself
      PSD = abs(XLr) .^ 2; % NOTE: not normalized

      % S = [S, PSD(first_sample_index:last_sample_index)];
      S = [S, PSD];
  end

  disp(S);

  T = [0:frame_count - 1] * frame_shift / fs;

  % generate a frequency vector corresponding to PSD
  F = [0:fft_size - 1] / length(fft_size) * fs;

  disp(T);
  disp(length(T));

  disp(size(S));

  figure;
  PP=10*log10(S);
  surf(T,F,-PP,'EdgeColor','none');
  axis xy;
  axis tight;
  colormap(brighten(pink,0.3));
  view(0,90);
  shading interp;
  V=caxis;
  caxis([V(1) V(1)+60]);
  xlabel('Time (s)');
  ylabel('Frequency (Hz)');
  axis([T(1) T(end) 0 fs/2]);
end
