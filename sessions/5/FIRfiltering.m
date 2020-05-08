% [result_matlab,result_conv]=FIRfiltering(signal,filt);
%
% execute and check C code for standard FIR filtering
%
% INPUTS
%   signal          : input signal (mono)
%   filt            : FIR filter coefficients (parameter N=length(filt)-1)
% OUTPUTS
%   result_malab    : filt*signal, convolution result obtained in MATLAB with filter.m
%   result_conv     : filt*signal, convolution result obtained with your C code (standard FIR filter implementation)

function [result_matlab,result_conv]=FIRfiltering(signal,filt,algo);

% add the path to the release directory of your C code
dir='/home/bruno/potentialize/dsp/sessions/5/';

if nargin==2
   algo=2; 
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
fwrite(fid,[zeros(length(filt)-1,1);signal],'double');
fclose(fid);
fid=fopen([dir 'filter.bin'],'w');
fwrite(fid,filt,'double');
fclose(fid);

%Write simulation parameters to text file
fid=fopen([dir 'parameters.txt'],'w');
fprintf(fid,'%d\n',length(signal)+length(filt)-1);
fprintf(fid,'%d\n',length(filt)-1);
fprintf(fid,'%d\n',0);
fprintf(fid,'%d\n',0);
fprintf(fid,'%d\n',algo);
fclose(fid);

%C-based standard FIR filtering
actdir=pwd;
cd(dir)
eval(['! ./fastconvolution.out'])
cd(actdir)

%Retrieve filtered data from files
fid=fopen([dir 'result_conv.bin'],'r');
result_conv=fread(fid,inf,'double');
result_conv=result_conv(length(filt):end);
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






