#!/bin/bash
#SBATCH --job-name=reprise_randomised_chunk
#SBATCH --partition=aoraki
#SBATCH --cpus-per-task=24                         # At least 2 CPUs per GPU
#SBATCH --mem=600GB                                # Adjust based on memory requirements
#SBATCH --time=2-00:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err                         # Save errors to jobname_jobid.err
#SBATCH --array=1-40

INPUT_BASE="/weka/health_sciences/bms/biochemistry/dearden_lab/galta815/hi-c/new_chunking_method"
OUTPUT_BASE="/projects/health_sciences/bms/biochemistry/dearden_lab/Taylor/Hox_Annotation/REPrise"
ID=$(printf "%02d" ${SLURM_ARRAY_TASK_ID})

IN_FILE="${INPUT_BASE}/iter_${ID}.fa"
OUT_DIR="${OUTPUT_BASE}/randomised_chunk_${ID}"

mkdir -p "${OUT_DIR}"
mkdir -p logs

if [ -f "${IN_FILE}" ]; then
    echo "Processing ID: ${ID}"
    echo "Input: ${IN_FILE}"
    echo "Output: ${OUT_DIR}"

    ./REPrise \
        -input "${IN_FILE}" \
        -output "${OUT_DIR}"
else
    echo "Error: Input file ${IN_FILE} not found."
    exit 1
fi
