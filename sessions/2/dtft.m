% X=dtft(x,phi);
%
% discrete-time Fourier transform
%
% INPUTS
%   x   : time-domain signal
%   phi : vector containing the frequencies relative to the sampling frequency
%         for which the DTFT has to be evaluated
% OUTPUT
%   X   : DTFT of x

% Example call: dtft([0 0 0 0 1 0 0 0 0], [0:0.0001:0.5]);

function X = dtft(x,phi)
    K=length(x); % item = k
    L=length(phi); % item = l

    X=zeros(length(phi),1); % initialize X (matrix with #length(phi) rows, #1 column)
    
    for l = 1:L
       for k = 1:K
           X(l) = X(l) + x(k) * exp(-1i*2*pi*phi(l)*(k-1));
       end
    end

    subplot(2,1,1) % make a Bode plot of X
    plot(phi,abs(X))
    xlabel('frequency relative to sampling frequency')
    ylabel('magnitude)')
    grid
    subplot(2,1,2)
    plot(phi,unwrap(angle(X))*180/pi)
    xlabel('frequency relative to sampling frequency')
    ylabel('phase (degrees)')
    grid
end