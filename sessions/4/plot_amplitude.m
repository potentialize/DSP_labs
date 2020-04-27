% f: frequency vector (x-axis)
% Yd: discrete fourier coefficients (y-axis)

function plot_amplitude(f, Yd, yText)
  % parse yText
  if nargin < 3
    yText = 'Output';
  end
  yText = sprintf('| %s | (dB)', yText);

  semilogx(f, 20*log10(abs(Yd)));
  xlabel('Frequency ( log(Hz) )');
  ylabel(yText);
end
