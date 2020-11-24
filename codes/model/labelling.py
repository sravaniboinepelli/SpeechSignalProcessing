import numpy as np
import pandas as pd
import json
import os
import pickle
import random
import sklearn.metrics
import re
import sys

# To run: 
# python labelling.py <pickle_filename>.pickle <path_to_input_directory>

filename_pkl = sys.argv[1]
data_dir = sys.argv[2]

max_features_from_file = 2471
# max_features_from_file = 180000


def get_df_from_file(filename, label_key):
    df = pd.read_csv(data_dir+filename)
    # print(df)
    df = df[0:max_features_from_file]
    df_t = df.transpose()
    # df_t['label'] = label_df[label_key]
    # print(df_t)
    # print(df_t.describe())
    return df_t

curr_feat_processed = 0
num_feat_set = 3
filelist = os.listdir(data_dir)
print(filelist)

filelist = sorted(filelist, key=lambda x: x.split('_')[2])
# Labels: 1 -> oriya, 2 -> punjabi, 3 -> assam, 4 -> kannada, 5 -> vi
label_df = {"oriya":1,"punjab":2, 'assam': 3, "kannada": 4, "vi": 5}
df_final = pd.DataFrame()
print(filelist)
featr_fr = []
featr_amp = []
featr_gd = []
df_final = pd.DataFrame()

# Input files of the format <feature type:gp/ia/if>_<language>_<file_number>.txt

for filename in filelist:
    split_fname = filename.split("_")
    print(split_fname)
    if filename.endswith(".txt"):
        if split_fname[0] == "ia":
            curr_feat_processed += 1
            df_amp = get_df_from_file(filename, split_fname[1])
        elif split_fname[0] == "if":
            curr_feat_processed += 1
            df_if = get_df_from_file(filename, split_fname[1])
        elif split_fname[0] == "gp":
            curr_feat_processed += 1
            df_gd = get_df_from_file(filename, split_fname[1])
        else:
            print("unknown extension data dropped")
        if curr_feat_processed == num_feat_set:
            df = pd.concat([df_amp, df_if, df_gd], axis=1, sort=False)
            df['label'] = label_df[split_fname[1]]
            curr_feat_processed = 0

            df_final = df_final.append(df)

print(len(df_final))
pkl_fd = open(filename_pkl, "wb")
pickle.dump(df_final, pkl_fd)

pkl_fd.close()

with open(filename_pkl, "rb") as read_fp:
    while 1:
        try:
            df1 = pickle.load(read_fp)
            # print(df1.describe())
            # print(df1.info())
            print(len(df1))
        except EOFError:
            print("exception end of file")
            break
