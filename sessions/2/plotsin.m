function [x,X]=plotsin(fs,M,N,L,window)
    f=M*fs/N;
    x=sin(2*pi*f*[0:N-1]'/fs).*window;

    X=abs(fft(x));

    figure
    subplot(2,1,1)
    plot([0:N-1],x,'k.:')
    xlabel('Discrete-time index k')
    title([num2str(M) ' periods of the sine fit into the length-' num2str(N) ' window'])

    subplot(2,1,2)
    plot([0:N-1],X,'k.')
    hold on
    xlabel('Frequency bin n')
    ylabel('Magnitude (lin)')

    y=[x;zeros(L-N,1)];  
    Y=abs(fft(y));
    plot([0:L-1]/L*N,Y,'r:')
end