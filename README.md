<p align="center"><img src="imgs/bear.png"
alt="BEAR with FALCON" height="222" border="0" /><br><br>
<b>Composition analysis of a Poolepynten <i>ursus maritimus</i> ancient sample</b></p>
<br>

<b>Download:</b>
<pre>
git clone https://github.com/pratas/bear.git
cd bear/
</pre>
<b>Download a build PUM:</b>
<pre>
chmod +x *.sh
./GetBear.sh
gunzip *.gz
./Trim.sh
</pre>

<b>Build the database (DB):</b>
<pre>
chmod +x *.sh
perl DownloadViruses.pl
perl DownloadArchaea.pl
perl DownloadBacteria.pl
perl DownloadFungi.pl
./DownloadMTV2.sh
./DownloadPlastidV2.sh
cat viruses.fa bacteria.fa archaea.fa fungi.fa mito.fna plast.fna | tr ' ' '_' \
| ./goose-extractreadbypattern complete_genome > DB.fa
</pre>

<b>Run metagenomic analysis:</b>
<pre>
./runIndividual.sh
</pre>


<b>Ancient DNA authentication scripts:</b>
<pre>
./runAuthCHIV14.sh               
./runAuthGeobacillus.sh  
./runAuthUrsus.sh
./runAuthCarrot.sh               
./runAuthTomato.sh
./runAuthHaloTrap.sh     
./runAuthCutibacterium.sh        
./runAuthRetrovirus.sh
./runAuthFlavobacteriumPhage.sh  
</pre>

Attention: external links, namely from NCBI repositories, may be broken with time, although they are easily fixed.

<b>Dependencies:</b>
<pre>
FALCON
AdapterRemoval
KESTREL
GULL
GOOSE
GeCo
</pre>
Although they are installed and used automatically.

License is GPLv3.
