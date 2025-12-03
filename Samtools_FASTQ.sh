#!/bin/bash
#SBATCH --job-name=samtools_fastq
#SBATCH --partition=aoraki
#SBATCH --cpus-per-task=16                         # At least 2 CPUs per GPU
#SBATCH --mem=64G                                # Adjust based on memory requirements
#SBATCH --time=5:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

singularity exec -B /projects /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Containers/samtools_v1.21-noble.sif \
	samtools fastq \
	-0 all_pacbio.fastq \
	/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/merged_pacbio.bam
