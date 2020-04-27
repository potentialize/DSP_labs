% f: frequency vector (x-axis)
% Xd: discrete Fourier coefficients of input
% Fd: discrete Fourier coefficients of filter
% Yd: discrete Fourier coefficients of output

function plot_filter(f, Xd, Fd, Yd)
  figure;
  subplot(3,1,1);
  plot_amplitude(f, Xd, 'Input');
  subplot(3,1,2);
  plot_amplitude(f, Fd, 'Filter');
  subplot(3,1,3);
  plot_amplitude(f, Yd, 'Output');
end
