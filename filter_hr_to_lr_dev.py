import json
import sys
import pandas as pd

if len(sys.argv) > 1:

    obj_list = []
    for filename in sys.argv[1:]:
        with open(filename, 'r') as json_file:
            obj_list += [json.loads(json_str) for json_str in list(json_file)]

    df = pd.DataFrame(obj_list)
    print (len(obj_list))
    df = df[['input', 'output']]
    df.to_csv("big.tsv", sep="\t", index=False, header=None)
else:
    print ("Usage: filter_hr.py *.jsonl")
