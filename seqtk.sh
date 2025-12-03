#!/bin/bash
#SBATCH --job-name=seqtk_fq2fasta
#SBATCH --partition=aoraki
#SBATCH --cpus-per-task=24
#SBATCH --mem=300G
#SBATCH --time=3-00:00:00
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err

set -euo pipefail

CONTAINER="/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Containers/seqtk_1.4.sif"
INFILE="/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/Kraken/classified_reads.fastq"
OUTFILE="/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/Kraken/classified_reads.fasta"

# Avoid shell, use seqtk directly, and avoid redirection
singularity exec -B /projects "$CONTAINER" \
	seqtk seq -A "$INFILE" \
	/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/Kraken/classified_read_ids.txt \
	 > "$OUTFILE"
