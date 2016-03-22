#!/bin/bash
#SBATCH -N 1                        # one node
#SBATCH --ntasks-per-node=1         # run on one node
#SBATCH -t 06:00:00                 # max runtime is 4 hours
#SBATCH -J controller               # name of job
##SBATCH -p main                    # backfill queue (specify your preferred queue here)
##SBATCH --mail-type=ALL             # send emails for job start/stop/error
##SBATCH --mail-user=$mail
#SBATCH -o ipc.controller.out       # use %J to add job name
# start controller listening on all ip's
ipcontroller --profile=slurm --ip='*'
