#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks-per-node=5
#SBATCH --mem=10GB
#SBATCH -t  04:00:00
#SBATCH -J engine
#SBATCH -p main
#SBATCH -o ipc.engine-%J.out
hostname=$1
srun -n 5 -c1 --mem=10GB ipengine --profile=slurm --location=$hostname