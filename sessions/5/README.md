# Install FFTW on Linux
Ref: http://micro.stanford.edu/wiki/Install_FFTW3

1. Grab the latest version of FFTW on http://fftw.org/download.html (3.3.8 as of writing)
2. Unzip the archive
3. Open the archive folder in a terminal (e.g. `cd ~/Downloads/fftw-3.3.8`)
4. Run `./configure --prefix=$HOME/usr --enable-shared=yes`
5. Run `make --jobs=8`
6. Run `make install`
   - this installs a bunch of files under `~/usr/include` and `~/usr/lib`

# Code fixes
## `int` vs `long int` Warning
Replace `%d` with `%ld`.

## `FIRfiltering.m` Eval
(causes `Error using fread` when MatLab tries to load `result_conv.bin`)

Make sure line 50 contains the right file name.

Note: On Linux you have to explicitly state that you want to execute a program
from the current working directory. (e.g. `./fastconvolution.out`)

## Segmentation Fault When Running `fastconvolution.out`
`fastconvolution.out` throws a segmentation fault when some files it tries
to read, are not present. Run `FIRfiltering.m` first and make sure it
generates all the necessary data files.
(Note: A segmentation fault can have many other causes.)

# Makefile Commands
- `make fastconvolution`: compile `fastconvolution.cpp`
  (make sure that the paths in `Makefile` are correctly set)
- `make clean-data`: delete all files that a run of `FIRfiltering.m` generates.
- `make clean`: delete all generated files (i.e. data files and compiler output)
