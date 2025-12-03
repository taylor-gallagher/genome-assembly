#!/bin/bash
#SBATCH --job-name=multiqc
#SBATCH --cpus-per-task=36
#SBATCH --mem=250G
#SBATCH --time=2-12:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --partition=aoraki

singularity exec -B /projects /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Containers/multiqc_v1.28.sif \
	multiqc \
	/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/Kraken/Kraken_Out_Confidence_0.01/kraken2.report.txt

