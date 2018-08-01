#!/bin/bash
chmod +x *.sh
./runGull.sh top-v.csv viruses.fa
./runGull.sh top-a.csv archaea.fa
./runGull.sh top-b.csv bacteria.fa
./runGull.sh top-mt.csv mito.fna
./runGull.sh top-pl.csv plast.fna
#
./runGull.sh top-cont-mito.txt mito.fna
#
