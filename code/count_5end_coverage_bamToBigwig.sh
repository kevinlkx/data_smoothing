## Compute the 5' read coverge on the entire genome

filein=$1
strand=$2
fileout=$3

genome_chrom_sizes=/project/compbio/jointLCLs/reference_genomes/hg19/hg19.chrom.sizes

echo "Compute genome coverage for ${filein} ${strand} strand"

## 1. sort BED file by chr and position
samtools view -b ${filein} | \

## 2. extend each interval to cover the fragment being sequenced
## slopBed -i stdin -s -l flank_left -r flank_right | \

## 3. count genome coverage, 5' end, strand ..., save as bedGraph, then BigWig
genomeCoverageBed -bg -5 -strand ${strand} -ibam stdin -g ${genome_chrom_sizes} > ${fileout}.bedGraph

echo "convert bedGraph to bigwig"

## 4. covert bedGraph to Bigwig
sort -k1,1 -k2,2n ${fileout}.bedGraph > ${fileout}.sorted.bedGraph
bedGraphToBigWig ${fileout}.sorted.bedGraph ${genome_chrom_sizes} ${fileout}.bw

rm ${fileout}.bedGraph ${fileout}.sorted.bedGraph

echo "finished computing genome coverage as: ${fileout} "
