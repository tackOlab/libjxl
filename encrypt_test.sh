#!/bin/zsh

mkdir -p work

PSNRCMD=~/Documents/Clone/WG1/OpenHTJ2K/build-relwithdebinfo/bin/imgcmp
ENC=build/tools/cjxl
DEC=build/tools/djxl

ENCOUT=work/out.jxl
NOENCOUT=work/noenc.jxl
DECENCOUT=work/enc.ppm
DECDECOUT=work/dec.ppm
DECNOENCOUT=work/noenc.ppm

$ENC $1 $ENCOUT -d $2 --pencrypt --num_threads=0
$ENC $1 $NOENCOUT -d $2 --num_threads=0

$DEC $NOENCOUT $DECNOENCOUT --num_threads=0
$DEC $ENCOUT $DECDECOUT --decrypt --num_threads=0
$DEC $ENCOUT $DECENCOUT --num_threads=0

$PSNRCMD $DECDECOUT $DECNOENCOUT
$PSNRCMD $1 $DECNOENCOUT
$PSNRCMD $1 $DECENCOUT

