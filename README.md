# Alpine Docker container with NumPy and OpenBLAS

[![](https://images.microbadger.com/badges/image/slothai/numpy.svg)](https://microbadger.com/images/slothai/numpy)

In order to support [OpenBLAS](http://www.openblas.net/) in [NumPy](http://www.numpy.org/), one need to manually [build it](http://www.numpy.org/devdocs/user/building.html) from source using `site.cfg` config.

### Container breakdown

* 30.5Mb [Official Python Alpine-based image](https://hub.docker.com/r/library/python/tags/3.6.5-alpine3.7/).
* 10.8Mb [OpenBlas](https://hub.docker.com/r/slothai/openblas/) `/opt/OpenBLAS` dependency.
* 58.0Mb = 32.9Mb NumPy + 21.9Mb [gfortran](https://pkgs.alpinelinux.org/package/edge/main/x86/gfortran) + misc.

### Notes

* Use parallel build `python setup.py build --parallel=$(nproc)`, it saves ~70% of time.
* In order to pass C flags to python use `CFLAGS="-Ofast"`. It overrides original settings, see [documentation](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#Optimize-Options).
* NumPy is installed to `/usr/local/lib/python3.6/site-packages/`.

### Links

* [What is the relation between BLAS, LAPACK and ATLAS](https://stackoverflow.com/questions/17858104/what-is-the-relation-between-blas-lapack-and-atlas) @StackOverflow.
* [Numerical Linear Algebra Packages on Linux](https://www.seehuhn.de/pages/linear): BLAS, LAPACK, ATLAS.
* [BLAS, LAPACK, CLAPACK, LAPACKE, ATLAS, OpenBLAS tutorials in C](https://github.com/Foadsf/Cmathtuts).
