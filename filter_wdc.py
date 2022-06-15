import json
import sys
import pandas as pd

if len(sys.argv) == 2:

    files = []
    with open(sys.argv[1]) as f:
        for p in f:
            files.append(p.strip())

    obj_list = []
    for filename in files:
        with open(filename, 'r') as json_file:
            obj_list += [json.loads(json_str) for json_str in list(json_file)]

    df = pd.DataFrame(obj_list)
    print (len(obj_list))
    df = df[['input', 'output']]
    df.to_csv("big.tsv", sep="\t", index=False, header=None)
else:
    print ("Usage: filter_hr.py file_list.json")
