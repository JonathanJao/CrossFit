# Build Baseline
```bash
for TASK in quoref wiki_split ethos-disability yelp_polarity superglue-rte glue-cola ethos-sexual_orientation blimp-sentential_negation_npi_scope ai2_arc amazon_polarity race-high blimp-sentential_negation_npi_licensor_present tweet_eval-irony break-QDMR crawl_domain freebase_qa glue-qnli hatexplain ag_news circa
do sbatch --output=$TASK.out --error=$TASK.err $SCRATCH/CrossFit/slurm/baseline_singletask.slurm $TASK
done
```

# Tune middle stage WDC

```bash
sbatch tune_middle_stage_wdc.slurm
```

```bash
TASK_SPLIT=dataloader/custom_tasks_splits/cross_random_tables_5k.json
python cli_multitask.py \
--do_train \
--train_dir tsv_files \
--custom_tasks_splits ${TASK_SPLIT} \
--total_steps 16980 \
--warmup_steps 1018 \
--model facebook/bart-base \
--output_dir models/upstream-multitask \
--train_batch_size 32 \
--num_train_epochs 10;
```

# Fine Tune HR
```bash

for TASK in quoref wiki_split ethos-disability yelp_polarity superglue-rte glue-cola ethos-sexual_orientation blimp-sentential_negation_npi_scope ai2_arc amazon_polarity race-high blimp-sentential_negation_npi_licensor_present tweet_eval-irony break-QDMR crawl_domain freebase_qa glue-qnli hatexplain ag_news circa
do
sbatch --output=$TASK.out --error=$TASK.err $SCRATCH/CrossFit/slurm/tune_final_stage_wdc.slurm $TASK
done
```

