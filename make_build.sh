#!/bin/bash

cmake -B./build -DCMAKE_CXX_COMPILER=/opt/homebrew/opt/llvm/bin/clang++ -DCMAKE_C_COMPILER=/opt/homebrew/opt/llvm/bin/clang -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -G Ninja -DCMAKE_LINKER=ld.lld
