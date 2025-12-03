#!/bin/bash
#SBATCH --job-name=kraken2_confidence
#SBATCH --partition=aoraki
#SBATCH --cpus-per-task=24
#SBATCH --mem=300G
#SBATCH --time=3-00:00:00
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err

set -euo pipefail

# Paths
KRAKEN2_DB="/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/Kraken/VW_RNA_Seq"
CONTAINER="/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Containers/kraken2_2.1.3.sif"
OUTPUT_DIR="/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/Kraken/Kraken_Out_Confidence_0.01"

# Define output files
REPORT_FILE="${OUTPUT_DIR}/kraken2.report.txt"
OUTPUT_FILE="${OUTPUT_DIR}/kraken2.output.txt"

# Run Kraken2
singularity exec -B /projects "$CONTAINER" \
 	kraken2 \
	--db "$KRAKEN2_DB" \
	--threads 24 \
	--confidence 0.01 \
	--report "$REPORT_FILE" \
	--output "$OUTPUT_FILE" \
	/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/all_pacbio.fastq

