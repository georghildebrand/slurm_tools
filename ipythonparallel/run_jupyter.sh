#!/bin/bash
#######
# Runs a ipcluster in the non HPC mode
# adopted from:
# https://rcc.fsu.edu/docs/parallel-ipython-programming-hpc-and-spear
#######
#SBATCH -N1
#SBATCH -c 4        #number of cpu
#SBATCH -J"jupyter"
#SBATCH --mem=40000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=georg.hildebrand@zalando.de
#SBATCH -p ssd
#SBATCH -w z-lxslurm06
#activating env
source ~/.profile
#try to add anaconda to pythonpath
anaconda
#activate env
source activate p27
#run the master script
jupyter notebook --no-browser


