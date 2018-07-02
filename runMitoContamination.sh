#!/bin/bash
# GET FALCON
# GET KESTREL
# GET GULL
#
# GET PUM
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Ursus_maritimus/CHR_Un/29073_ref_UrsMar_1.0_chrUn.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Ursus_maritimus/CHR_MT/29073_ref_UrsMar_1.0_chrMT.fa.gz
zcat 29073_ref_UrsMar_1.0_chrUn.fa.gz | grep -v ">" | tr -d -c "ACGTN" > UM.seq
zcat 29073_ref_UrsMar_1.0_chrMT.fa.gz | grep -v ">" | tr -d -c "ACGTN" >> UM.seq
# ===
./KESTREL -v -i -F -n 12 -m 6:1:1:0/0 -m 12:10:0:0/0 -m 14:100:1:3/1 -m 20:200:1:5/10 -c 250 -g 0.98 -t 0.95 -o PUM_CONTAMINATION.fq UM.seq PUM.fq
# ===
(time ./FALCON -v -n 12 -t 1000 -F -Z -c 250 -y complexity-cont.com -x top-cont-mito.txt PUM_CONTAMINATION.fq mito.fna ) &> REPORT-CONT_FALCON
./FALCON-FILTER -v -F -sl 0.05 -du 20000000 -t 0.5 -o positions-cont.pos complexity-cont.com
./FALCON-EYE -v -F -e 500 -sl 8 -o draw-cont.svg positions-cont.pos
