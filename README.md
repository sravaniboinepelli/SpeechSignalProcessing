## SpeechSignalProcessing

Group delay features for openly available language
identification data project
1. Code running:

a. For feature extraction:
Go to feature_extraction  ->  files_folder_<lg>   ->  code  -> run - sgroup_delay.m and inst_freq.m
Use the output files from the sgroup_delay(group phase) and inst_freq ( instantaneous frequency and instantaneous amplitude )

b.Model running:

2. Process:

a. Data:
1. Download the data from  https://drive.google.com/drive/folders/1qgM1a-vLCsmMrLv3iJOgOmAyRTwNx7SN
2. Create train_folder, test_folder, dev_folder in the clips folder of each language
3. Copy the file names from each category and save it in a <type>.txt file (example:train.txt).
  
4. Split the train and text from the tsv files using copying.py
  
b. Feature Extraction:
1. Run the sgroup_delay.m in the files folder itself and the output is saved in gp_i.m (i = ith file)
2. Run inst_features.m (change the name of the language of the output files according to the language).
3. Instantaneous amplitude values are saved in  ia_<languagename>_i.txt and instantaneous frequencies are saved in if_<languagename>_i.txt

c. Model:


