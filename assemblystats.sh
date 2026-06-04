#!/bin/bash
#SBATCH --job-name=assemblystats_pacbio
#SBATCH --partition=aoraki
#SBATCH --cpus-per-task=64                         # At least 2 CPUs per GPU
#SBATCH --mem=64GB                                # Adjust based on memory requirements
#SBATCH --time=01:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

singularity exec -B /projects /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Containers/assembly-stats_version-1.0.1-docker1.sif \
	assembly-stats \
	/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/pacbio_native.asm.bp.p_ctg.fasta \
	2> log.log
