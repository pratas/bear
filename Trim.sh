#!/bin/bash
GET_AR=1;
RUN_AR=1;
#==============================================================================
if [[ "$GET_AR" -eq "1" ]]; then
  git clone https://github.com/MikkelSchubert/adapterremoval.git
  cd adapterremoval/
  make
  cd ..
  cp adapterremoval/build/AdapterRemoval .
fi 
#==============================================================================
if [[ "$RUN_AR" -eq "1" ]]; then
  # What about thiS: SRR518649.fastq.bz2?
  bunzip2 SRR518649_1.fastq.bz2
  bunzip2 SRR518649_2.fastq.bz2
  AdapterRemoval --file1 SRR518649_1.fastq --file2 SRR518649_2.fastq --basename OP_SRR518649 --trimns --trimqualities --collapse  
fi
#==============================================================================

#SRR518649.fastq.bz2
