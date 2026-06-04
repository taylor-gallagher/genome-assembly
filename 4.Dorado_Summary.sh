#!/bin/bash
#SBATCH --job-name=dorado_summary
#SBATCH --partition=aoraki_gpu                    # Partition with GPUs
#SBATCH --gpus-per-node=1                # Request 1 GPU
#SBATCH --cpus-per-task=2                         # At least 2 CPUs per GPU
#SBATCH --mem=64GB                                # Adjust based on memory requirements
#SBATCH --time=7-00:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

singularity exec --nv -B /projects /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/dorado_nanoporetech_0.8.2.sif \
        dorado summary \
	-x -r "cuda:all" -v \
	/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/Dorado_Out/velvetworm_duplex.bam
