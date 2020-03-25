% y=invert(x,N);
%
% blockwise time reversal
%
% INPUTS
%   x   : input signal
%   N   : block size
% OUTPUT
%   y   : blockwisely time reversed signal 

function y=invert(x,N);

% y = [];
y=zeros(length(x),1); % calloc (allocate memory for the output signal and assign zeros)
for n=1:floor((length(x))/N)  % step through the signal in steps of N samples, parameter n then is the block index
    i = n-1; % index starting at 0
    
    % get a block of N samples from the input stream x
    block = x(i*N+1:n*N);
    
    % invert the block
    block = block(end:-1:1);
    
    % update output (y)
    % y = [y, block];
    y(i*N+1:n*N) = block;
end