#!/bin/bash
#
REFERENCE="archaea_filtered.fq";
TARGET="archaea.fa";
#
git clone https://github.com/pratas/geco.git
cd geco/src/
cmake .
make
cp GeCo ../../
cd ../../
#
./GeCo -v -e -rm 4:1:0:0/0 -rm 8:10:0:0/0 -rm 11:10:0:0/0 -rm 14:50:1:3/1 -rm 18:500:1:5/10 -c 200 -g 0.95 -r $REFERENCE $TARGET &> REPORT_GECO
./goose-UpperBound 2.0 < $TARGET.iae > $TARGET.iae.upper
cp $TARGET.iae $TARGET.iae.upper
./goose-filter -w 2001 -d 10 -wt 2 -1 < $TARGET.iae.upper > $TARGET.iae.upper.fil
gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_$REFERENCE.pdf"
  set auto
  set size ratio 0.12
  unset key
  set yrange [0:2.5]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "$TARGET.iae.upper.fil" u 1:2 w l ls 2 title "normal"
EOF
