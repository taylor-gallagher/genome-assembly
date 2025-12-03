#!/bin/bash
#SBATCH --job-name=sort_samtools
#SBATCH --partition=aoraki
#SBATCH --cpus-per-task=16                         # At least 2 CPUs per GPU
#SBATCH --mem=64G                                # Adjust based on memory requirements
#SBATCH --time=5:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

singularity exec -B /projects /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Containers/samtools_v1.21-noble.sif \
	samtools sort \
	-o sorted_pacbio.bam \
	/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/Raw_Data/AGRF_CAGRF25030080-1_PacBio/all_pacbio.bam
