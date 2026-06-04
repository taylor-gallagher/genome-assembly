#!/bin/bash

#SBATCH --job-name=reprise_cdhit
#SBATCH --partition=aoraki_long
#SBATCH --cpus-per-task=128                         # At least 2 CPUs per GPU
#SBATCH --mem=600GB                                # Adjust based on memory requirements
#SBATCH --time=30-00:00:00                           # Set appropriate time (48 hours here, adjust as needed)
#SBATCH --output=%x_%j.out                        # Save output to jobname_jobid.out
#SBATCH --error=%x_%j.err 

# Define the output filename for the stats
STATS_FILE="rarefaction_counts.txt"

# Loop through the cumulative sets (1 to 40)
for i in {1..40}; do
    
    # Format i with a leading zero (01, 02...)
    printf -v I_PADDED "%02d" $i
    CHUNK_LABEL="1-${I_PADDED}"

    # 1. NEW RESUME LOGIC: Check if this label already exists in the text file
    if [ -f "$STATS_FILE" ] && grep -q "^${CHUNK_LABEL}[[:space:]]" "$STATS_FILE"; then
        echo "Stats for $CHUNK_LABEL already exist in $STATS_FILE. Skipping..."
        continue
    fi
    
    OUTPUT_FASTA="pool_${i}_nr.fasta"
    TEMP_POOL="temp_pool_${I_PADDED}.fasta"
    
    # Ensure we start with a clean temp file
    > "$TEMP_POOL"
    
    echo "----------------------------------------------------"
    echo "Processing Set $CHUNK_LABEL: Building pool..."

    # Inner loop: Combine files 01 through i
    for j in $(seq 1 $i); do
        printf -v J_PADDED "%02d" $j
        CURRENT_FILE="randomised_chunk_${J_PADDED}.reprof"
        
        if [ -f "$CURRENT_FILE" ]; then
            awk -v prefix="chunk_${J_PADDED}_" '/^>/ {print ">"prefix substr($0,2); next} {print}' "$CURRENT_FILE" >> "$TEMP_POOL"
        else
            echo "ERROR: $CURRENT_FILE not found. Exiting."
            exit 1
        fi
    done

    # 2. Run CD-HIT-EST
    echo "Running CD-HIT for $CHUNK_LABEL..."
    cd-hit-est -i "$TEMP_POOL" -o "$OUTPUT_FASTA" -c 0.8 -n 5 -d 0 -M 0 -T 0 > /dev/null

    # 3. Count sequences
    RAW_COUNT=$(grep -c "^>" "$TEMP_POOL")
    CLUSTERED_COUNT=$(grep -c "^>" "$OUTPUT_FASTA")
    
    # 4. Append to stats file
    # If the file doesn't exist, create it with a header first
    if [ ! -f "$STATS_FILE" ]; then
        echo -e "Chunk_Set\tRaw_Sequences\tUnique_Clusters_CDHIT" > "$STATS_FILE"
    fi
    echo -e "${CHUNK_LABEL}\t${RAW_COUNT}\t${CLUSTERED_COUNT}" >> "$STATS_FILE"
    
    echo "Completed $CHUNK_LABEL: Raw=$RAW_COUNT -> Unique=$CLUSTERED_COUNT"

    # Clean up the large temp pool file
    rm "$TEMP_POOL"
done

echo "----------------------------------------------------"
echo "Analysis Complete."
