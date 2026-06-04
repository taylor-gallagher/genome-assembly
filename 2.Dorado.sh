#!/bin/bash
#SBATCH --job-name=2.dorado.sh
#SBATCH --partition=aoraki                      
#SBATCH --cpus-per-task=32
#SBATCH --mem=128GB                               # Adjust based on memory requirements
#SBATCH --time=5-00:00:00                         # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

pod5 subset /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/All_Pod5/ \
	--summary summary.tsv \
	--columns channel \
	--output split_by_channel
