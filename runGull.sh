#!/bin/bash
RUN_GULL=1;
GET_GULL=1;
GET_GOOSE=1;
TOP_FILE="$1"; 
DB_FILE="$2";
#==============================================================================
# GET GULL
#
if [[ "$GET_GULL" -eq "1" ]]; then
  rm -fr GULL/ GULL-map GULL-visual
  git clone https://github.com/pratas/GULL.git
  cd GULL/src/
  cmake .
  make
  cp GULL-map ../../
  cp GULL-visual ../../
  cd ../../
fi
#==============================================================================
# GET GOOSE
#
if [[ "$GET_GOOSE" -eq "1" ]]; then
  rm -fr goose/ goose-*
  git clone https://github.com/pratas/goose.git
  cd goose/src/
  make
  cp goose-* ../../
  cd ../../
fi
#==============================================================================
# RUN GULL
if [[ "$RUN_GULL" -eq "1" ]]; then
  cat $TOP_FILE | awk '{ if($3 > 1.0) print $1"\t"$2"\t"$3"\t"$4; }' \
  | awk '{ print $4;}' | tr '_' '\t' | awk '{ print $2;}' > GIS;
  idx=0;
  cat GIS | while read line
    do
    namex=`echo $line | tr ' ' '_'`;
    if [[ "$idx" -eq "0" ]]; then
      printf "%s" "$namex" > FNAMES.fil;
      else
      printf ":%s" "$namex" >> FNAMES.fil;
    fi
    ./goose-extractreadbypattern $line < $DB_FILE > $namex;
    ((idx++));
    done
  ./GULL-map -v -m 18:500:1:5/50 -m 13:200:1:3/10 -m 10:100:1:0/0 -m 6:1:0:0/0 -m 3:1:0:0/0 -c 20 -g 0.95 -n 4 -x MATRIXxA.csv `cat FNAMES.fil`
  ./GULL-visual -v -w 25 -a 4 -x HEATMAP-Arch.svg MATRIXxA.csv
fi
#==============================================================================
