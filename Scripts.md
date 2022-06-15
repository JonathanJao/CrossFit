# Build Baseline
```bash
for TASK in $(ls $SCRATCH/CrossFit/data)
do sbatch --output=$TASK.out --error=$TASK.err baseline_singletask.slurm $TASK
done
```

# Tune middle stage HR to LR Dev
```bash
sbatch tune_middle_stage_hr.slurm
```

# Tune middle stage WDC

```bash
sbatch tune_middle_stage_wdc.slurm
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