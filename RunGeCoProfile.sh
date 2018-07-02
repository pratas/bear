#!/bin/bash
#
# =================================================== #
#                                                     #
#          WARING: Run ONLY AFTER filter!             #
#                                                     #
# =================================================== #
#
GET_GOOSE=0;
GET_GECO=1;
COMPRESS_DC=1;
COMPRESS_SELF_DC=1;
PLOT=1;
#
#==============================================================================
# GET GOOSE
if [[ "$GET_GOOSE" -eq "1" ]]; then
  rm -fr goose/ goose-*
  git clone https://github.com/pratas/goose.git
  cd goose/src/
  make
  cd ../../
  cp goose/src/goose-* .
  cp goose/scripts/*.sh .
fi
#==============================================================================
# GET FALCON
if [[ "$GET_GECO" -eq "1" ]]; then
  git clone https://github.com/pratas/geco.git
  cd geco/src/
  cmake .
  make
  cp GeCo ../../
  cd ../../
fi
#==============================================================================
###############################################################################
#==============================================================================
# COMPRESS
if [[ "$COMPRESS_DC" -eq "1" ]]; then
  (time ./GeCo -v -e -rm 6:1:0:0/0 -rm 13:10:0:0/0 -rm 14:50:1:3/1 -rm 20:100:1:5/10 -c 150 -r filtered-carrots.fq dc.fa ) &> REPORT-dc ;
fi
#==============================================================================
# COMPRESS SELF
if [[ "$COMPRESS_SELF_DC" -eq "1" ]]; then
  cp dc.fa dc-SELF.fa
  (time ./GeCo -v -e -tm 4:1:0:0/0 -tm 8:1:0:0/0 -tm 13:10:1:1/1 -tm 16:50:1:3/1 -c 15 dc-SELF.fa ) &> REPORT-SELF-dc ;
  (time ./GeCo -v -e -tm 4:1:0:0/0 -tm 8:1:0:0/0 -tm 13:10:1:1/1 -tm 16:50:1:3/1 -c 15 rev-dc-SELF.fa ) &> REPORT-SELF-dc ;
fi
#==============================================================================
###############################################################################
#==============================================================================
# PLOT
if [[ "$PLOT" -eq "1" ]]; then
  #
  #
  ./goose-UpperBound 2.0 < dc.fa.iae > dc.fa.upper
  ./goose-UpperBound 2.0 < dc-SELF.fa.iae > dc-SELF.fa.upper
  ./goose-filter -w 201 -d 5 -wt 2 -1 < dc.fa.upper > dc.fa.fil
  ./goose-filter -w 201 -d 5 -wt 2 -1 < dc-SELF.fa.upper > dc-SELF.fa.fil
  #
  #
gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_dc.pdf"
  set auto
  set size ratio 0.08
  unset key
  set yrange [0:2.1]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "dc.fa.fil" u 1:2 w l ls 2 title "normal"
EOF

# SELF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "Prof_dc_self.pdf"
  set auto
  set size ratio 0.08
  unset key
  set yrange [0:2.1]
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  set style line 1 lt 1 lc rgb '#0039D4' lw 3
  set style line 2 lt 1 lc rgb '#0B69D4' lw 3
  plot "dc-SELF.fa.fil" u 1:2 w l ls 2 title "normal"
EOF

fi
#==============================================================================
