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


function [PSD,F]=periodogram(
    x,
    win,
    frame_size,
    P,
    L,
    fs,
    mode
)
    % initialize the output with zeros
    PSD=zeros(length(x) ,1);
    
    % inialize frame counter
    frame_count=0;
    
    % m = last element in frame
    % NOTE: m may not land at length(x), in which case the last few
    %       elements are ignored
    for last_in_frame  =frame_size:P:length(x)
        first_in_frame = last_in_frame - frame_size + 1;
        
        frame_count = frame_count+1;
        
        % current frame
        frame=x((last_in_frame-frame_size+1):last_in_frame,1);
        
        disp(frame);
%         windowedframe=???;              % window the frame
%         zeropaddedframe=[??];           % zero-pad the windowed frame
%         XLr=???                         % calculate XLr[n]
%         PSD=PSD+???                     % add a new |XLr|² to the partial sum
    end
%     alpha=fs*sum(win.^2);               % compute normalization factor
%     PSD=PSD/R/alpha;                    % normalize PSD by R and alpha
% 
%     F=[??:??]*??;                       % generate a frequency vector corresponding to PSD
% 
%     figure
%     PSDss=PSD(1:length(PSD)/2+1);
%     PSDss(2:length(PSD)/2)=PSDss(2:length(PSD)/2)*2;    % single-sided PSD
%     Fss=F(1:length(F)/2+1);
%     if (nargin==6) | (mode==1)
%         h=semilogx(Fss,10*log10(PSDss),'k');
%     else
%         h=plot(Fss,10*log10(PSDss),'k');
%     end
%     set(h,'LineWidth',2);
%     axislimits=axis;
%     axis([Fss(2) fs/2 axislimits(3) axislimits(4)])
%     grid
%     xlabel('Frequency (Hz)');
%     ylabel('Power spectral density (dB)')
end


