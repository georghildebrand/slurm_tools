#!/bin/bash

#starting a cluster
echo "Starting master <run_master.sh>"
sbatch run_master.sh
echo "finished"

lastjob=$(sacct |tail -n1|awk '{print $1}')
masterhostname=$(scontrol show job $lastjob|grep "NodeList"|tail -n1 |awk -F "=" '{print $2}')

echo "starting engines"
sbatch run_engines.sh $masterhostname
echo "Done!"

echo "Join more engines by running: sbatch 01_run_engines.sh $masterhostname on other servers"

echo "Stop the cluster with scancel -u $USER"