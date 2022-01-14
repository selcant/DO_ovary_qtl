#!/bin/bash
#SBATCH --job-name=ova_perm
#SBATCH -q batch 
#SBATCH --mem 64GB # memory pool for all cores
#SBATCH -N 1 # number of nodes
#SBATCH -n 16 # number of cores
#SBATCH -t 2-00:00 # time (D-HH:MM)
#SBATCH --mail-type=END
#SBATCH	--mail-user=selcan.aydin@jax.org 


module load singularity
echo "Starting the Rscript!"

echo "singularity exec docker://rocker/tidyverse:4.1.0 Rscript /projects/munger-lab/projects/DO_ovary_QTL/get_perm.R"
singularity exec docker://rocker/tidyverse:4.1.0 Rscript /projects/munger-lab/projects/DO_ovary_QTL/get_perm.R

echo "Done!"
