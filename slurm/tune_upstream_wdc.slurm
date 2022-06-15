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


conda activate crossfit_debug
cd $SCRATCH/CrossFit
TASK_SPLIT=dataloader/custom_tasks_splits/cross_random_tables_5k.json
python cli_multitask.py \
--do_train \
--train_dir tsv_files \
--custom_tasks_splits ${TASK_SPLIT} \
--total_steps 16980 \
--warmup_steps 1018 \
--model facebook/bart-base \
--output_dir models/wdc-upstream-multitask \
--train_batch_size 32 \
--num_train_epochs 10;