#!/bin/bash
# conda install mapDamage bowtie2 samtools;
#
# INPUT maize.fa auth-fil-maize-x.fq
#
REFERENCE="maize";
#
bowtie2-build -f $REFERENCE.fa $REFERENCE
bowtie2 --threads 12 --end-to-end --very-sensitive -x $REFERENCE -U auth-fil-$REFERENCE-x.fq -S REFERENCE.sam
samtools view -bS -q30 -F4 $REFERENCE.sam > FIL-$REFERENCE.bam
mapDamage --rescale -i FIL-$REFERENCE.bam -r $REFERENCE.fa;
#
