#!/bin/bash

#SBATCH --account=ec443
#SBATCH --nodes=1
#SBATCH --partition=accel
#SBATCH --gpus=a100:1
#SBATCH --mem=100G
#SBATCH --time=00:15:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2

# Load necessary modules and activate environment
module list
module purge
module load Python/3.11.5-GCCcore-13.2.0 Python-bundle-PyPI/2023.10-GCCcore-13.2.0
module load PyYAML/6.0.1-GCCcore-13.2.0
#module load IPython/8.17.2-GCCcore-13.2.0
module load lxml/4.9.3-GCCcore-13.2.0

module list

# get GPU info
nvidia-smi

# Run the Python script that is given as an argument
python3 ${@}

# Confirm job completion
echo "Job completed"