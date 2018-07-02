#!/bin/bash
(time ./FALCON -v -n 1 -t 800 -F -Z -c 250 -y complexity-mt.com -x top-mt.csv PUM.fq mito.fna ) &> REPORT-MT_FALCON
./FALCON-FILTER -v -F -sl 0.001 -du 20000000 -t 0.5 -o positions-mt.pos complexity-mt.com 
./FALCON-EYE -v -F -e 500 -sl 8 -o draw-mt.svg positions-mt.pos
#
(time ./FALCON -v -n 1 -t 800 -F -Z -c 250 -y complexity-pl.com -x top-pl.csv PUM.fq plast.fna ) &> REPORT-PL_FALCON
./FALCON-FILTER -v -F -sl 0.001 -du 20000000 -t 0.5 -o positions-pl.pos complexity-pl.com
./FALCON-EYE -v -F -e 500 -sl 8 -o draw-pl.svg positions-pl.pos
#
(time ./FALCON -v -n 8 -t 800 -F -Z -c 250 -y complexity-v.com -x top-v.csv PUM.fq viruses.fa ) &> REPORT-V_FALCON
./FALCON-FILTER -v -F -sl 0.001 -du 20000000 -t 0.5 -o positions-v.pos complexity-v.com
./FALCON-EYE -v -F -e 500 -sl 8 -o draw-v.svg positions-v.pos
#
(time ./FALCON -v -n 8 -t 800 -F -Z -c 250 -y complexity-a.com -x top-a.csv PUM.fq f-archaea.fa ) &> REPORT-A_FALCON
./FALCON-FILTER -v -F -sl 0.001 -du 20000000 -t 0.5 -o positions-a.pos complexity-a.com
./FALCON-EYE -v -F -e 500 -sl 8 -o draw-a.svg positions-a.pos
#
(time ./FALCON -v -n 8 -t 800 -F -Z -c 250 -y complexity-b.com -x top-b.csv PUM.fq f-bacteria.fa ) &> REPORT-B_FALCON
./FALCON-FILTER -v -F -sl 1 -du 20000000 -t 0.5 -o positions-b.pos complexity-b.com
./FALCON-EYE -v -F -e 500 -sl 9.3 -o draw-b.svg positions-b.pos
#
(time ./FALCON -v -n 8 -t 800 -F -Z -c 250 -y complexity-f.com -x top-f.csv PUM.fq f-fungi.fa ) &> REPORT-F_FALCON
./FALCON-FILTER -v -F -sl 0.001 -du 20000000 -t 0.5 -o positions-f.pos complexity-f.com
./FALCON-EYE -v -F -e 500 -sl 8 -o draw-f.svg positions-f.pos
#
