#!/bin/bash
#SBATCH --job-name=arthropod_BUSCO      # Job name
#SBATCH --nodes=1                       # Use one node
#SBATCH --ntasks-per-node=1             # Number of tasks
#SBATCH --cpus-per-task=8               # Number of CPU cores
#SBATCH --mem=200G                        # Memory allocation
#SBATCH --time=4:00:00                  # Time limit (HH:MM:SS)
#SBATCH --output=busco_athropod_genome.out        # Standard output
#SBATCH --error=busco_arthropod_genome.err         # Standard error
#SBATCH --partition=aoraki

singularity exec -B /weka busco_v5.8.2_cv1.sif  \
	busco \
	-i /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/pacbio_native.asm.bp.p_ctg.fasta \
	-l arthropoda_odb10 \
	-o genome_output \
	-m geno \
	-c 8 \
	-f 
