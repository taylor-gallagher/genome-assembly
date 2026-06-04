#!/bin/bash
#SBATCH --job-name=contig_chunking
#SBATCH --cpus-per-task=32
#SBATCH --mem=200GB
#SBATCH --nodes=1
#SBATCH --time=7-00:00:00
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err
#SBATCH --partition=aoraki

for list in new_chunking_method/iter_*.list; do
  outfa=new_chunking_method/$(basename "$list" .list).fa
  > "$outfa"
  while read contig; do
    samtools faidx final_assembly.fasta "$contig" >> "$outfa"
  done < "$list"
done
