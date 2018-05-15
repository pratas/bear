#!/bin/bash
rm -f plastid.2.1.genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/refseq/release/plastid/plastid.2.1.genomic.fna.gz
zcat plastid.2.1.genomic.fna.gz > plast.fna
