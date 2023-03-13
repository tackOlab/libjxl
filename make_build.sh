#!/bin/bash

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export CMAKE_PREFIX_PATH=`brew --prefix giflib`:`brew --prefix jpeg-turbo`:`brew --prefix libpng`:`brew --prefix zlib`

cmake -B./build -DCMAKE_CXX_COMPILER=/opt/homebrew/opt/llvm/bin/clang++ -DCMAKE_C_COMPILER=/opt/homebrew/opt/llvm/bin/clang -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -G Ninja -DCMAKE_LINKER=ld.lld
