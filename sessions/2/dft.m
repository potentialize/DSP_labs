% XN=dft(xN);
%
% Discrete Fourier transform
%
% INPUTS
%   x   : time-domain signal
% OUTPUT
%   X   : DFT of x

function XN=dft(xN)
    N=length(xN); % item = n

    XN=zeros(N,1); % initialize X (matrix with #length(phi) rows, #1 column)
    
    for n = 1:N % loop over phi
       for k = 1:N % loop over x
        XN(n) = XN(n) + xN(k) * exp(-1i*2*pi*(n-1)*(k-1)/N);
       end
    end
    
    % normalize???

    subplot(2,1,1)          % make a Bode plot of X
    plot(1:N,abs(XN))
    xlabel('frequency relative to sampling frequency')
    ylabel('magnitude)')
    grid
    subplot(2,1,2)
    plot(1:N,unwrap(angle(XN))*180/pi)
    xlabel('frequency relative to sampling frequency')
    ylabel('phase (degrees)')
    grid
end