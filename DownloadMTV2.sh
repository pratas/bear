#!/bin/bash
rm -f mitochondrion.1.1.genomic.fna.gz mitochondrion.2.1.genomic.fna.gz;
wget ftp://ftp.ncbi.nlm.nih.gov/refseq/release/mitochondrion/mitochondrion.1.1.genomic.fna.gz
wget ftp://ftp.ncbi.nlm.nih.gov/refseq/release/mitochondrion/mitochondrion.2.1.genomic.fna.gz
zcat mitochondrion.1.1.genomic.fna.gz mitochondrion.2.1.genomic.fna.gz > mito.fna
