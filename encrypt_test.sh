#!/bin/zsh

EFFORT=${2:-7}

if [ $EFFORT -gt 7 ]; then
	echo "**** WARNING **** effort value greater than 7 will not be losslessly decryptable."
fi

DISTANCE[1]=0.01
DISTANCE[2]=0.05
DISTANCE[3]=0.1
DISTANCE[4]=0.25
DISTANCE[5]=0.5
DISTANCE[6]=1.0
DISTANCE[7]=1.5
DISTANCE[8]=2.0
DISTANCE[9]=2.5
DISTANCE[10]=3.0


mkdir -p work

PSNRCMD=~/Documents/OpenHTJ2K/build/bin/imgcmp
ENC=build/tools/cjxl
DEC=build/tools/djxl

printf "-distance, encrypted.jxl (Bytes), normal.jxl (Bytes), diff(percent)\n"
for d in ${DISTANCE[@]}
do
#	printf $d
#	printf ", "
	ENCOUT=work/out$d.jxl
	NOENCOUT=work/noenc$d.jxl
	SIZE_E=`$ENC $1 $ENCOUT --pencrypt --num_threads=0 -d $d -e $EFFORT --quiet`
#	printf ", "
	SIZE_N=`$ENC $1 $NOENCOUT --num_threads=0 -d $d -e $EFFORT --quiet`
	DIFF=$(( $SIZE_E - $SIZE_N ))
	PERCENT=`echo "scale=5; 100 * $DIFF / $SIZE_N" | bc`
	printf "%6.2f %8d, %8d, %8.4f" $d $SIZE_E $SIZE_N $PERCENT
	printf "\n"
done

printf "\n"

printf "* Errors between encrypted and original (PAE,MSE,PSNR):\n"
for d in ${DISTANCE[@]}
do
	printf "%6.2f" $d
	printf ", "
	ENCOUT=work/out$d.jxl
	DECENCOUT=work/enc$d.ppm
	$DEC $ENCOUT $DECENCOUT --num_threads=0 --quiet
	$PSNRCMD $1 $DECENCOUT
done

printf "\n"

printf "* Errors between decrypted and non-encrypted (PAE,MSE,PSNR):\n"
for d in ${DISTANCE[@]}
do
	printf "%6.2f" $d
	printf ", "
	ENCOUT=work/out$d.jxl
	NOENCOUT=work/noenc$d.jxl
	DECDECOUT=work/dec$d.ppm
	DECNOENCOUT=work/noenc$d.ppm
	$DEC $NOENCOUT $DECNOENCOUT --num_threads=0 --quiet
	$DEC $ENCOUT $DECDECOUT --decrypt --num_threads=0 --quiet
	$PSNRCMD $DECDECOUT $DECNOENCOUT
done

printf "\n"

printf "* Errors between original and non-encrypted (PAE,MSE,PSNR):\n"
for d in ${DISTANCE[@]}
do
	printf "%6.2f" $d
	printf ", "
	NOENCOUT=work/noenc$d.jxl
	DECNOENCOUT=work/noenc$d.ppm
	$DEC $NOENCOUT $DECNOENCOUT --num_threads=0 --quiet
	$PSNRCMD $1 $DECNOENCOUT
done
