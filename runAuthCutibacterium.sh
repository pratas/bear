#!/bin/bash
#
# DEPENDENCIES: KESTREL & BIOCONDA
# 
PARAM_KESTREL=" -v -F -n 10 -m 3:1:0:0/0 -m 6:1:1:0/0 -m 9:10:1:0/0 -m 14:100:1:3/10 -g 0.98 -t 0.95 ";
#
REFERENCE="cutibacterium";
TARGET="PUM.fq";
#
GET_KESTREL=0;
GET_PROGS=0;
GET_SEQ=1;
GET_GOOSE=0;
#
RUN_KESTREL=1;
RUN_DAMAGE=1;
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
# GET GOOSE
#
if [[ "$GET_GOOSE" -eq "1" ]]; then
  rm -rf goose/ goose-*
  git clone https://github.com/pratas/goose.git
  cd goose/src/
  make
  cp goose-* ../../
  cd ../../
fi
#==============================================================================
# GET BWA, SAMTOOLS and MAPDAMAGE2 with Bioconda:
#
if [[ "$GET_PROGS" -eq "1" ]]; then
  conda install bwa
  conda install samtools
  conda install mapdamage2
fi
#==============================================================================
# GET SEQUENCE
#
if [[ "$GET_SEQ" -eq "1" ]]; then
 rm -f GCF_003030305.1_ASM303030v1_genomic.fna.gz GCF_003030305.1_ASM303030v1_genomic.fna cutibacterium.fa
 wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/030/305/GCF_003030305.1_ASM303030v1/GCF_003030305.1_ASM303030v1_genomic.fna.gz
 gunzip GCF_003030305.1_ASM303030v1_genomic.fna.gz 
 mv GCF_003030305.1_ASM303030v1_genomic.fna cutibacterium.fa
fi
#==============================================================================
# RUN KESTREL
if [[ "$RUN_KESTREL" -eq "1" ]]; then
  (time ./KESTREL $PARAM_KESTREL -o auth-fil-$REFERENCE-x.fq $REFERENCE.fa $TARGET ) &> REPORT-$REFERENCE;
fi
#==============================================================================
# RUN DAMAGE
if [[ "$RUN_DAMAGE" -eq "1" ]]; then
  rm -fr *index* results_FIL-$REFERENCE
  bwa index $REFERENCE.fa
  bwa mem -t 8 -I 0 -O 2 -N 0.02 -L 1024 -E 7 $REFERENCE.fa auth-fil-$REFERENCE-x.fq > $REFERENCE.sam
  samtools view -bSh $REFERENCE.sam > $REFERENCE.bam
  samtools view -bh -F4 $REFERENCE.bam > FIL-$REFERENCE.bam
  mapDamage --rescale -i FIL-$REFERENCE.bam -r $REFERENCE.fa;
fi
#==============================================================================

