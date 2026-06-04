#!/bin/bash
#SBATCH --job-name=chopper
#SBATCH --partition=aoraki
#SBATCH --cpus-per-task=96                         # At least 2 CPUs per GPU
#SBATCH --mem=256GB                                # Adjust based on memory requirements
#SBATCH --time=1-00:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

singularity exec -B /projects chopper_0.9.0--hdcf5f25_0.sif \
	chopper \
	-q 6 \
	-l 6000 \
	--threads 96 \
	-i /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/Samtools_Out/velvetworm_duplex.fastq \
	 > /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/Chopper_Out/velvetworm_corrected.fasta \
	2> /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/velvetworm_corrected.log
