#!/bin/bash
#SBATCH --job-name=samtools
#SBATCH --partition=aoraki                    
#SBATCH --cpus-per-task=2                         # At least 2 CPUs per GPU
#SBATCH --mem=64GB                                # Adjust based on memory requirements
#SBATCH --time=7-00:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

singularity exec -B /projects /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/samtools_1.21.sif \
	samtools bam2fq \
	-t \
	--threads 20 \
	/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/Dorado_Out/velvetworm_duplex.bam \
	> /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/Samtools_Out/velvetworm_duplex.fastq \
	2> /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/Samtools_Out/velvetworm_samtools.txt
