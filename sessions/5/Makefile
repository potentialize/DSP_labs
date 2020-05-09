# NOTE: single dollar ($) -> make variable...
#       double dollar ($$) -> environment variable (i.e. escape single dollar)
fastconvolutionPath = ./fastconvolution/fastconvolution.cpp
fftwLibPath = $$HOME/usr/lib
fftwIncludePath = $$HOME/usr/include

fastconvolution: $(fastconvolutionPath)
	g++ $(fastconvolutionPath) -lm -lfftw3 -L$(fftwLibPath) -I$(fftwIncludePath) -o fastconvolution.out

.PHONY: clean-data
clean-data:
	rm -f parameters.txt signal.bin filter.bin result_conv.bin result_fastconv.bin speed.txt

.PHONY: clean
clean: clean-data
	rm -f fastconvolution.out
