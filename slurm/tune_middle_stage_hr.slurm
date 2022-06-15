#!/bin/bash
#SBATCH --job-name=job_wgpu
#SBATCH --open-mode=append
#SBATCH --output=./%j_%x.out
#SBATCH --error=./%j_%x.err
#SBATCH --export=ALL
#SBATCH --time=24:00:00
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH -c 4

singularity exec --nv --overlay $SCRATCH/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04-20201207.sif /bin/bash -c "

source /ext3/env.sh
conda activate crossfit
cd $SCRATCH/CrossFit/
python cli_middle_stage.py --do_train --learning_rate 1e-5 --train_batch_size 32 --total_steps 16980 --eval_period 100 --warmup_steps 1018 --model facebook/bart-base --output_dir models/hr --train_file hr_data/big.tsv --dev_file hr_data/big.tsv --num_train_epochs 10;

"
