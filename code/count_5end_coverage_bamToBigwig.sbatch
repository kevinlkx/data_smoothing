#!/bin/bash

#SBATCH --job-name=coverage
#SBATCH --output=coverage_%J.out
#SBATCH --partition=broadwl
#SBATCH --mem-per-cpu=10G

#################################################################
# get 5' end coverage for bam files                             #
#################################################################

bamfile=$1
bwfile=$2

sh ~/projects/data_smoothing/data_smoothing_workflow/code/count_5end_coverage_bamToBigwig.sh ${bamfile} + ${bwfile}_forward

sh ~/projects/data_smoothing/data_smoothing_workflow/code/count_5end_coverage_bamToBigwig.sh ${bamfile} - ${bwfile}_reverse
