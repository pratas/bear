#!/bin/bash
#
# WARNING: FIRST RUN ./GetBear.sh and ./Trim.sh
# THIS WILL GENERATE: PUM.fq (THAT IS NEEDED FOR THIS COMPUTATION)
#
GET_KESTREL=1;
GET_FALCON=1;
GET_BEAR=1;
RUN_KESTREL=1;
RUN_FALCON=1;
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
# GET MODERN BEAR
#
if [[ "$GET_BEAR" -eq "1" ]]; then
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Ursus_maritimus/CHR_Un/29073_ref_UrsMar_1.0_chrUn.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Ursus_maritimus/CHR_MT/29073_ref_UrsMar_1.0_chrMT.fa.gz
  zcat 29073_ref_UrsMar_1.0_chrUn.fa.gz | grep -v ">" | tr -d -c "ACGTN" > UM.seq
  zcat 29073_ref_UrsMar_1.0_chrMT.fa.gz | grep -v ">" | tr -d -c "ACGTN" >> UM.seq
fi
#==============================================================================
# RUN KESTREL
#
if [[ "$RUN_KESTREL" -eq "1" ]]; then
  ./KESTREL -v -i -F -n 12 -m 6:1:1:0/0 -m 12:10:0:0/0 -m 14:100:1:3/1 -m 20:200:1:5/10 -c 250 -g 0.98 -t 0.95 -o PUM_CONTAMINATION.fq UM.seq PUM.fq
fi
#==============================================================================
# RUN FALCON
#
if [[ "$RUN_FALCON" -eq "1" ]]; then
  (time ./FALCON -v -n 12 -t 1000 -F -Z -c 250 -y complexity-cont.com -x top-cont-mito.txt PUM_CONTAMINATION.fq mito.fna ) &> REPORT-CONT_FALCON
  ./FALCON-FILTER -v -F -sl 0.05 -du 20000000 -t 0.5 -o positions-cont.pos complexity-cont.com
  ./FALCON-EYE -v -F -e 500 -sl 8 -o draw-cont.svg positions-cont.pos
fi
