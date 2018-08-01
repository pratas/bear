#!/bin/bash
#
REFERENCE="parvo.fa";
TARGET="PUM.fq";
RXNAME="PARVO";
#
GET_KESTREL=1;
GET_FALCON=1;
RUN_KESTREL=1;
RUN_FALCON=1;
#
#==============================================================================
# GET KESTREL
#
if [[ "$GET_KESTREL" -eq "1" ]]; then
  rm -rf kestrel/ KESTREL
  git clone https://github.com/pratas/kestrel.git
  cd kestrel/src/
  cmake .
  make
  cp KESTREL ../../
  cd ../../
fi
#==============================================================================
# GET FALCON
#
if [[ "$GET_FALCON" -eq "1" ]]; then
  rm -fr falcon FALCON FALCON-* *.pl
  git clone https://github.com/pratas/falcon.git
  cd falcon/src/
  cmake .
  make
  cp FALCON ../../
  cp FALCON-FILTER ../../
  cp FALCON-EYE ../../
  cd ../../
fi
#==============================================================================
# RUN KESTREL
if [[ "$RUN_KESTREL" -eq "1" ]]; then
  (time ./KESTREL -v -n 10 -F -m 14:200:1:4/50 -m 12:50:1:1/10 -m 6:10:0:0/0 -g 0.95 -o filtered-$RXNAME.fq -t 0.5 $REFERENCE $TARGET ) &> REPORT;
fi
#==============================================================================
# RUN FALCON
if [[ "$RUN_FALCON" -eq "1" ]]; then
  (time ./FALCON -v -n 8 -t 200 -F -Z -c 10 -x top-$RXNAME.csv -y complexity-$RXNAME.txt filtered-$RXNAME.fq $REFERENCE ) &> REPORT-FALCON-$RXNAME ;
  (time ./FALCON-FILTER -v -F -sl 0.001 -du 20000000 -t 0.5 -o positions-$RXNAME.txt complexity-$RXNAME.txt ) &> REPORT-FALCON-FILTER-$RXNAME ;
  (time ./FALCON-EYE -v -F -e 100 -s 4 -sl 4.15 -o draw-$RXNAME.svg positions-$RXNAME.txt ) &> REPORT-FALCON-EYE-$RXNAME ;
fi
#==============================================================================

