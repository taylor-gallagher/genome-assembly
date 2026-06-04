#!/bin/bash
#SBATCH --job-name=dorado_duplex_basecalling
#SBATCH --partition=aoraki_gpu                    # Partition with GPUs
#SBATCH --gpus-per-node=1                         # Request 1 GPU
#SBATCH --cpus-per-task=2                         # At least 2 CPUs per GPU
#SBATCH --mem=64GB                                # Adjust based on memory requirements
#SBATCH --time=7-00:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err

# Load the required module for GPU support (if needed)
module load cuda

# Change to Weka for the temporary directory
cd /weka/health_sciences/bms/biochemistry/dearden_lab/velvetworm_bragato

# Run Dorado in Singularity
singularity exec --nv -B /projects /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/dorado_nanoporetech_0.8.2.sif \
         dorado duplex \
        -r -x "cuda:all" -v \
        /models/dna_r10.4.1_e8.2_400bps_sup@v5.0.0/ \
        /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/split_by_channel \
	 > velvetworm_basecalling/velvetworm_duplex.bam \
	2> velvetworm_basecalling/velvetworm_duplex.log

# Once the job is done, move results to the final destination
mv velvetworm_basecalling/velvetworm_duplex.bam /projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Velvetworm_Bragato_Dec42024/Dorado_Out/

# Delete the temp directory on Weka
rm -rf /weka/health_sciences/bms/biochemistry/dearden_lab/velvetworm_bragato
