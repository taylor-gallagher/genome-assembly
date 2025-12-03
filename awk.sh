#!/bin/bash
#SBATCH --job-name=classified_ids
#SBATCH --partition=aoraki
#SBATCH --cpus-per-task=24
#SBATCH --mem=300G
#SBATCH --time=3-00:00:00
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err

awk '$1 == "C" { print $2 }' Kraken_Out/kraken2.output.txt > classified_read_ids.txt
