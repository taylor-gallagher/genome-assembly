#!/bin/bash
#SBATCH --job-name=hifiasm_pacbio_native
#SBATCH --partition=aoraki_bigmem
#SBATCH --cpus-per-task=64                         # At least 2 CPUs per GPU
#SBATCH --mem=1TB                                # Adjust based on memory requirements
#SBATCH --time=14-00:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

singularity exec -B /projects /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Containers/hifiasm_v0.25.0.sif \
	hifiasm \
	-t 64 \
	-o pacbio_native.asm \
	/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/PacBio/all_pacbio.fastq
