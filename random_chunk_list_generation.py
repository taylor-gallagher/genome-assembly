#run by doing python (script name) (index.fai) (output folder name)

#!/usr/bin/env python3
import sys
import os
import random
import argparse

def parse_args():
    parser = argparse.ArgumentParser(description="Create randomized genomic chunks with a hard size cap.")
    parser.add_argument("fai", help="Path to assembly.fasta.fai")
    parser.add_argument("outdir", help="Output directory for lists")
    parser.add_argument("-n", "--iterations", type=int, default=40, help="Number of random chunks to generate")
    parser.add_argument("-s", "--size_cap", type=int, default=2000000000, help="Target chunk size cap in bytes (Default: 2GB)")
    parser.add_argument("--seed", type=int, default=None, help="Random seed")
    return parser.parse_args()

def main():
    args = parse_args()
    
    if args.seed is not None:
        random.seed(args.seed)

    os.makedirs(args.outdir, exist_ok=True)

    # 1. Read Contigs
    print(f"Reading {args.fai}...")
    contigs = []
    
    with open(args.fai) as fh:
        for line in fh:
            parts = line.split()
            name = parts[0]
            length = int(parts[1])
            contigs.append((name, length))

    print(f"Loaded {len(contigs)} contigs.")
    
    target_size = args.size_cap
    print(f"Target Size Cap: {target_size/1e9:.4f} GB")
    print("Logic: Greedy fill (skip contigs that would exceed the cap).")

    # 2. Generate Random Iterations
    for i in range(1, args.iterations + 1):
        # Shuffle the genome for this iteration
        pool = contigs[:]
        random.shuffle(pool)
        
        current_bin = []
        current_size = 0
        
        for name, length in pool:
            if current_size + length <= target_size:
                current_bin.append(name)
                current_size += length
            
            if current_size == target_size:
                break
        
        outfile = os.path.join(args.outdir, f"iter_{i:02d}.list")
        with open(outfile, "w") as o:
            o.write("\n".join(current_bin) + "\n")
        
        print(f"  [Iter {i}] Wrote {len(current_bin)} contigs ({current_size/1e9:.9f} GB) to {outfile}")

if __name__ == "__main__":
    main()
