% [B,A]=peakfilter(gain,fc,fb,fs);
%
% second-order peak filter
%
% INPUTS
%   gain    : desired gain at fc (dB)
%   fc      : center frequency (Hz)
%   fb      : 3 dB bandwidth (Hz)
%   fs      : sampling frequency (Hz)
% OUTPUTS (frequency domain)
%   B       : numerator polynomial
%   A       : denominator polynomial

function [B,A]=peakfilter(gain,fc,fb,fs)
  h0 = 10^(gain/20) - 1;
  d = -cos(2 * pi * fc/fs);

  if gain >= 0
    c = (tan(pi * fb/fs) - 1) / (tan(pi * fb/fs) + 1);
  else
    c = (tan(pi * fb/fs) - 1 - h0) / (tan(pi * fb/fs) + 1 + h0);
  end

  % NOTE: last inderminate of both N and T is z^0
  T = [-c, d * (1 - c), 1]; % correct with / z^2
  N = [1, d * (1 - c), -c]; % correct with / z^2

  % NOTE: z^2 / z^2 (from N and T) cancels out
  % NOTE: a * N = [a*n1, a*n2, ...]
  % NOTE: N - T = [n1-t1, n2-t2, ...]
  B = (1 + h0/2) * N - (h0/2) * T;
  A = N;
end
