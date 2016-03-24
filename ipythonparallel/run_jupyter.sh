#!/bin/bash
#######
# Runs a ipcluster in the non HPC mode
# adopted from:
# https://rcc.fsu.edu/docs/parallel-ipython-programming-hpc-and-spear
#######
#SBATCH -N1
#SBATCH -c 4        #number of cpu
#SBATCH -J"jupyter"
#SBATCH -t 04:00:00 # time limit
#SBATCH --mem=40000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=<mail_user>
#SBATCH -p <partition>
#SBATCH -w <server>

#run the master script
jupyter notebook --no-browser


