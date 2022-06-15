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

echo "Startup Parameters:"
echo $1 # N
echo $2 # TASK
singularity exec --nv --overlay $SCRATCH/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04-20201207.sif /bin/bash -c "

source /ext3/env.sh
conda activate crossfit
cd $SCRATCH/CrossFit/
echo "Parameters:"
echo $1
echo $2
python tune_hps_singletask.py --task_dir data/$2/ --do_train --do_predict --learning_rate_list 1e-5 2e-5 5e-5 --bsz_list 2 4 8  --total_steps 1000  --eval_period 100  --warmup_steps 100  --model facebook/bart-base  --checkpoint models/hr/$1-model.pt --output_dir models/hr_results/$1-$2  --predict_batch_size 32 
"