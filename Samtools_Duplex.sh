#!/bin/bash
#SBATCH --job-name=samtools
#SBATCH --partition=aoraki                    
#SBATCH --cpus-per-task=2                         # At least 2 CPUs per GPU
#SBATCH --mem=64GB                                # Adjust based on memory requirements
#SBATCH --time=2-00:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

singularity exec -B /projects /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Containers/samtools_v1.21-noble.sif \
	samtools view /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/Dorado_Out/velvetworm_duplex.bam | grep -c "dx:i:1"
