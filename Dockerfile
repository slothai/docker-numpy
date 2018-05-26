# vim:set ft=dockerfile:
FROM slothai/openblas as openblas
FROM python:3.6.5-alpine3.7

ARG NUMPY_VERSION=1.14.3

COPY --from=openblas /opt/OpenBLAS/ /opt/OpenBLAS/

RUN apk add --no-cache --virtual .meta-build-dependencies \
        gcc \
        musl-dev && \
    apk add --no-cache gfortran && \
    wget -O numpy.tar.gz "https://github.com/numpy/numpy/archive/v$NUMPY_VERSION.tar.gz" && tar xzf numpy.tar.gz && rm -f numpy.tar.gz && \
    echo -e "[openblas]\n\
libraries = openblas\n\
library_dirs = /opt/OpenBLAS/lib\n\
include_dirs = /opt/OpenBLAS/include\n\
runtime_library_dirs = /opt/OpenBLAS/lib\
" > /numpy-$NUMPY_VERSION/site.cfg && \
    pip install Cython==0.28.2 && \
    cd /numpy-$NUMPY_VERSION/ && python setup.py build --parallel=$(nproc) --fcompiler=gfortran && python setup.py install && cd / && \
    rm -rf /numpy-$NUMPY_VERSION/ && \
    pip uninstall --yes Cython && \
    apk del .meta-build-dependencies && \
    find / -type d -name __pycache__ -exec rm -r {} +
