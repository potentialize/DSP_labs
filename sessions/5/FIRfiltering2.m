% [result_matlab,result_conv,result_fastconv]=FIRfiltering2(signal,filt,FFT_size,frame_shift);
%
% execute and check C code for standard and overlap-save fast convolution based FIR filtering
%
% INPUTS
%   signal          : input signal (mono)
%   filt            : FIR filter coefficients (parameter N=length(filt)-1)
%   FFT_size        : size of the (I)FFTs used by the fast convolution algorithm (parameter M)
%   frame_shift     : frame shift used by the fast convolution algorithm (parameter P)
% OUTPUTS
%   result_malab    : filt*signal, convolution result obtained in MATLAB with filter.m
%   result_conv     : filt*signal, convolution result obtained with your C code (standard FIR filter implementation)
%   result_fastconv : filt*signal, convolution result obtained with your C code (overlap-save fast convolution implementation)

function [result_matlab,result_conv,result_fastconv]=FIRfiltering2(signal,filt,FFT_size,frame_shift,algo);

% add the path to the release directory of your C code
dir='C:\Koen\digitale signaalverwerking\oefeningen\session5\ex2\fastconvolution\Release\';

if nargin==4
   algo=2; 
end
if nargin==2
   FFT_size=0;
   frame_shift=0;
   algo=2;
else
    signal=signal(1:floor(length(signal)/frame_shift)*frame_shift);
    if frame_shift>FFT_size-length(filt)+1
       disp('Fast convolution code fails because frame_shift>FFT_size-length(filt)+1') 
       result_matlab=-1;
       result_conv=-1;
       result_fastconv=-1;
       return
    end
end

% Matlab-based filtering
t=cputime;
if algo>=0
    result_matlab=filter(filt,1,signal);
else
    result_matlab=-1;
end
time_matlab=cputime-t;

%Write signal + filter coefficients to binary files
fid=fopen([dir 'signal.bin'],'w');
fwrite(fid,[zeros(FFT_size-frame_shift,1);signal],'double');
fclose(fid);
fid=fopen([dir 'filter.bin'],'w');
fwrite(fid,filt,'double');
fclose(fid);

%Write simulation parameters to text file
fid=fopen([dir 'parameters.txt'],'w');
fprintf(fid,'%d\n',length(signal)+FFT_size-frame_shift);
fprintf(fid,'%d\n',length(filt)-1);
fprintf(fid,'%d\n',FFT_size);
fprintf(fid,'%d\n',frame_shift);
fprintf(fid,'%d\n',algo);
fclose(fid);

%C-based standard FIR filtering and fast convolution
actdir=pwd;
cd(dir)
eval(['! fastconvolution.exe'])
cd(actdir)

%Retrieve filtered data from files
fid=fopen([dir 'result_conv.bin'],'r');
result_conv=fread(fid,inf,'double');
result_conv=result_conv(FFT_size-frame_shift+1:end);
fclose(fid);
fid=fopen([dir 'result_fastconv.bin'],'r');
result_fastconv=fread(fid,inf,'double');
result_fastconv=result_fastconv(FFT_size-frame_shift+1:end);
fclose(fid);

%Verify result
disp(' ')
error=0;
if algo>=0
    nrmconv=norm(result_matlab-result_conv)/norm(result_matlab);
    if norm(result_conv)>1e-10
        if nrmconv<1e-13
            disp(['C code for standard FIR filtering seems to work fine : error=' num2str(nrmconv)]);
        else
            disp(['C code for standard FIR filtering contains errors : error=' num2str(nrmconv)]);
            input('    Press enter to proceed ...')
            error=1;
        end
    else
        disp('C code for standard FIR filtering has not yet been implemented and/or produces zero output')
        input('    Press enter to proceed ...')
        error=1;
    end
    nrmfastconv=norm(result_matlab-result_fastconv)/norm(result_matlab);
    if norm(result_fastconv)>1e-10
        if nrmfastconv<1e-13
            disp(['C code for fast convolution based filtering seems to work fine : error=' num2str(nrmfastconv)]);
        else
            disp(['C code for fast convolution based filtering contains errors : error=' num2str(nrmfastconv)]);
            input('    Press enter to proceed ...')
            error=1;
        end
    else
        disp('C code for fast convolution based filtering has not yet been implemented and/or produces zero output')
        input('    Press enter to proceed ...')
        error=1;
    end
end

%Retrieve execution time data
if error==0
    if algo>=0
        disp(' ')
        disp(['Standard FIR filtering in Matlab with filter order ' num2str(length(filt)-1) ' lasted for ' num2str(time_matlab) ' seconds'])
    end
    disp(' ')
    fid=fopen([dir 'speed.txt'],'r');
    speedinfo=fscanf(fid,'%c',inf);
    disp(speedinfo)
    fclose(fid);
end






