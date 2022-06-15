# Build Baseline


# Tune middle stage HR to LR Dev


# Tune middle stage WDC



# Fine Tune HR
```bash

for TASK in $(ls $SCRATCH/CrossFit/data)
do
for N in {0..9}
do
# echo $N-$TASK
sbatch --export=N,TASK --output=$N-$TASK.out --error=$N-$TASK.err $SCRATCH/CrossFit/slurm/tune_final_stage_hr.slurm
done
done
```
# Fine Tune HR

```bash
for TASK in $(ls $SCRATCH/CrossFit/data)
do
for N in {0..9}
do
# echo $N-$TASK
sbatch --export=N,TASK --output=$N-$TASK.out --error=$N-$TASK.err $SCRATCH/CrossFit/slurm/tune_final_stage_hr.slurm
done
done
```