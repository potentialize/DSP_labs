% f: row vector of frequencies, onto which filter coefficients are mapped
% fs: sampling rate
% N: numerator coefficients of filter
% D: denominator coefficients of filter

% Fd: discrete Fourier coefficients of filter (row vector)

function Fd=discrete_tf(f, fs, N, D)
  % calculate z from f
  z = exp(1i * 2 * pi * f/fs);

  % evaluate polynomials for each value of f
  Nf = polyval(N, z);
  Df = polyval(D, z);

  % return row vector
  Fd = (Nf ./ Df)';
end
