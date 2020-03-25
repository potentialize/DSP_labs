% [PSD,F]=periodogram(x,win,N,P,L,fs,mode);
%
% Welch periodogram
%
% INPUTS
%   x       : signal
%   win     : windowing function (vector of length N)
%   N       : frame length
%   P       : frame shift
%   L       : FFT size
%   fs      : sampling frequency
%   mode    : if mode=0 the frequency axis is linearly spaced
%             if mode=1 the frequency axis is logaritmically spaced
% OUTPUTS
%   PSD     : PSD estimate
%   F       : corresponding frequency vector


function [PSD,F] = periodogram(x, window, frame_size, frame_shift, fft_size, fs, mode)
    % initialize the output with zeros
    PSD = zeros(fft_size, 1); % length of zero padded fft

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

        % summation of eq. 5.77
        PSD = PSD + abs(XLr) .^ 2;
    end

    disp(PSD);

    % normalization factor
    alpha = fs * sum(window .^ 2);

    % normalize PSD (scaling factor of eq. 5.77)
    PSD = PSD / frame_count / alpha;

    % generate a frequency vector corresponding to PSD
    F=[0:length(PSD) - 1]/length(PSD)*fs;

    figure;

    % single-sided PSD
    PSDss = PSD(1:length(PSD)/2+1);
    PSDss(2:length(PSD)/2)=PSDss(2:length(PSD)/2)*2;

    % single-sided frequency vector
    Fss=F(1:length(F)/2+1);

    if (nargin==6) | (mode==1) % mode omitted || log scale mode
        h=semilogx(Fss,10*log10(PSDss),'k');
    else
        h=plot(Fss,10*log10(PSDss),'k');
    end

    set(h, 'LineWidth', 2);
    axislimits = axis;
    axis([Fss(2) fs/2 axislimits(3) axislimits(4)]); % fmax = fs/2 (Nyquist)
    grid;
    xlabel('Frequency (Hz)');
    ylabel('Power spectral density (dB)');
end
