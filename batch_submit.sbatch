#!/bin/bash
#SBATCH --time=00:30:00
# #SBATCH --exclusive
#SBATCH --qos=gp_bsccs

# Number of nodes
#SBATCH -N2

# 112 cores per general purpose node MN5
#SBATCH --tasks-per-node=1

#SBATCH -A example

# If you did not set tasks per node, this will be used
DEFAULT_NTASKS_PER_NODE=1

NODELIST="$(scontrol show hostname $SLURM_JOB_NODELIST)"

NODELIST_WITH_COUNTS=""
for node in $NODELIST; do
    NTASKS=${SLURM_NTASKS_PER_NODE:-$DEFAULT_NTASKS_PER_NODE}
    NODELIST_WITH_COUNTS+="${node}:${NTASKS},"
done

# Just trim the trailing comma
NODELIST_WITH_COUNTS="${NODELIST_WITH_COUNTS%,}"

# Remember to set DMR_PATH to the location where the DMR source code is
cmd="$DMR_PATH/bin/dmr_wrapper prterun --host $NODELIST_WITH_COUNTS -np 2 --prtemca ras ^slurm --prtemca plm ^slurm -x LD_LIBRARY_PATH=/home/worker/TESTE/dmr/lib:$LD_LIBRARY_PATH ./hello-world"
#TROQUE O CAMINHO da flag -x para o seu

echo $cmd
$cmd
