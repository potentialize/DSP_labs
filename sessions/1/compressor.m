% [y,G]=compressor(x,CR1,CR2,xc,N);
%
% Static dynamic range compressor
%
% INPUTS
%   x   : input signal (matrix of size nr_samples x nr_channels)
%   CR1 : compression ratio in case the level exceeds xc
%   CR2 : compression ratio in case the level is below xc
%   xc  : threshold (knee point)
%   N   : horizon to compute the signal level
% OUTPUTS
%   y   : compressed signal
%   G   : gain that has been applied

function [y,G]=compressor(x,CR1,CR2,xc,N);

[nr_samples,nr_channels]=size(x);       % find length and number of channels of input
y=zeros(nr_samples,nr_channels);        % initialize output with zeros
G=zeros(nr_samples,1);                  % initialize gain vector with zeros

yc=xc^(1/CR1)                           % compute (xc,yc)
for k=N:N:length(x)                     % go through signal in steps of N
    block = x(k-N+1:k)
    
    level=max(abs(block))               % compute input level at time k
    if level>xc                         % compute gain at time k in case level>xc
        % RC1
        gain=      
    else                                % compute gain at time k in case level<=xc
        % RC2
        gain=...
    end
    y(...)=...                    	    % apply gain and compute output
    G(...)=gain;                        % save gain
end