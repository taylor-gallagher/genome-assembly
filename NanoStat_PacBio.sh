#!/bin/bash
#SBATCH --job-name=nanostat
#SBATCH --partition=aoraki                    
#SBATCH --cpus-per-task=8                         # At least 2 CPUs per GPU
#SBATCH --mem=64GB                                # Adjust based on memory requirements
#SBATCH --time=2-00:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

singularity exec -B /projects /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/containers/nanostat_1.6.0d-b1.sif \
	NanoStat --fastq all_pacbio.fastq --threads 8 > velvetworm_hifi_stats.txt
