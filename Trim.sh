#!/bin/bash
GET_AR=1;
RUN_AR=1;
#==============================================================================
if [[ "$GET_AR" -eq "1" ]]; then
  rm -fr adapterremoval/
  git clone https://github.com/MikkelSchubert/adapterremoval.git
  cd adapterremoval/
  make
  cd ..
  cp adapterremoval/build/AdapterRemoval .
fi
#==============================================================================
if [[ "$RUN_AR" -eq "1" ]]; then
  #
  ./AdapterRemoval --file1 SRR518649.fastq --basename SE_SRR518649 --trimns --trimqualities --minlength 20 --gzip
  ./AdapterRemoval --file1 SRR518649_1.fastq --file2 SRR518649_2.fastq --basename PE_SRR518649 --trimns --trimqualities --minlength 20 --gzip
  #
  ./AdapterRemoval --file1 SRR518651.fastq --basename SE_SRR518651 --trimns --trimqualities --minlength 20 --gzip
  ./AdapterRemoval --file1 SRR518651_1.fastq --file2 SRR518651_2.fastq --basename PE_SRR518651 --trimns --trimqualities --minlength 20 --gzip
  #
  ./AdapterRemoval --file1 SRR518654.fastq --basename SE_SRR518654 --trimns --trimqualities --minlength 20 --gzip
  ./AdapterRemoval --file1 SRR518654_1.fastq --file2 SRR518654_2.fastq --basename PE_SRR518654 --trimns --trimqualities --minlength 20 --gzip
  #
  ./AdapterRemoval --file1 SRR518655.fastq --basename SE_SRR518655 --trimns --trimqualities --minlength 20 --qualitybase 64 --gzip
  ./AdapterRemoval --file1 SRR518655_1.fastq --file2 SRR518655_2.fastq --basename PE_SRR518655 --trimns --trimqualities --minlength 20 --qualitybase 64 --gzip
  #
  ./AdapterRemoval --file1 SRR518656.fastq --basename SE_SRR518656 --trimns --trimqualities --minlength 20 --gzip
  ./AdapterRemoval --file1 SRR518656_1.fastq --file2 SRR518656_2.fastq --basename PE_SRR518656 --trimns --trimqualities --minlength 20 --gzip
  #
  ./AdapterRemoval --file1 SRR518657.fastq --basename SE_SRR518657 --trimns --trimqualities --minlength 20 --gzip
  ./AdapterRemoval --file1 SRR518657_1.fastq --file2 SRR518657_2.fastq --basename PE_SRR518657 --trimns --trimqualities --minlength 20 --gzip
  #
  ./AdapterRemoval --file1 SRR518704.fastq --basename SE_SRR518704 --trimns --trimqualities --minlength 20 --gzip
  ./AdapterRemoval --file1 SRR518704_1.fastq --file2 SRR518704_2.fastq --basename PE_SRR518704 --trimns --trimqualities --minlength 20 --gzip
  # 
  ./AdapterRemoval --file1 SRR518705.fastq --basename SE_SRR518705 --trimns --trimqualities --minlength 20 --gzip
  ./AdapterRemoval --file1 SRR518705_1.fastq --file2 SRR518705_2.fastq --basename PE_SRR518705 --trimns --trimqualities --minlength 20 --gzip
  #
  zcat *.truncated.gz > PUM.fq
fi
#==============================================================================