#!/bin/sh

export CPPFLAGS="-I$PREFIX/include $CPPFLAGS"
export CFLAGS="-I$PREFIX/include $CFLAGS"
export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
export DYLD_LIBRARY_PATH=$PREFIX/lib

set -x -e

INCLUDE_PATH="${PREFIX}/include"
LIBRARY_PATH="${PREFIX}/lib"

# Always build PIC code for enable static linking into other shared libraries
CXXFLAGS="${CXXFLAGS} -fPIC -std=c++14 -D_GLIBCXX_USE_CXX11_ABI=0"

if [ "$(uname)" == "Darwin" ]; then
    TOOLSET=clang
elif [ "$(uname)" == "Linux" ]; then
    TOOLSET=gcc
fi

./configure --prefix=$PREFIX --with-apr=$PREFIX

make
make install

