#!/bin/bash
#SBATCH --job-name=job_wgpu
#SBATCH --open-mode=append
#SBATCH --output=./%j_%x.out
#SBATCH --error=./%j_%x.err
#SBATCH --export=ALL
#SBATCH --time=05:00:00
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH -c 4

singularity exec --nv --overlay $SCRATCH/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04-20201207.sif /bin/bash -c "

source /ext3/env.sh
conda activate crossfit
cd $SCRATCH/CrossFit/
python cli_middle_stage.py \
    --task_dir middle_stage_data/ \
    --do_train --learning_rate 1e-5 \
    --train_batch_size 1 \
    --total_steps 6000 \
    --eval_period 100 \
    --warmup_steps 360 \
    --model facebook/bart-base \
    --output_dir models/middle_stage
    --num_train_epochs 40;
"
