#!/bin/bash
#SBATCH --job-name=kraken2_nt
#SBATCH --partition=aoraki
#SBATCH --cpus-per-task=24
#SBATCH --mem=300G
#SBATCH --time=3-00:00:00
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err

set -euo pipefail

# Paths
KRAKEN2_DB="/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Kraken2/k2_core_nt"
CONTAINER="/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Containers/kraken2_2.1.3.sif"
OUTPUT_DIR="/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/Kraken/Kraken_Out_NT"

# Define output files
REPORT_FILE="${OUTPUT_DIR}/kraken2.report.txt"
OUTPUT_FILE="${OUTPUT_DIR}/kraken2.output.txt"

# Run Kraken2
singularity exec -B /projects "$CONTAINER" \
 	kraken2 \
	--db "$KRAKEN2_DB" \
	--threads 24 \
	--report "$REPORT_FILE" \
	--output "$OUTPUT_FILE" \
	/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/all_pacbio.fastq

