## Speech Signal Processing Project

Group delay features for openly available language identification data project

By: Sravani Boinepelli (20171050) and Meghana Bommadi (20171165)

<br>

### How to run:

Run *codes/feature_extraction/sgroup_delay.m* for extracting modified group delay features. The output is saved as *gp_<language>_i.txt* (i = ith file)

Run *codes/feature_extraction/inst_features.m* for extracting instaneous amplitude/frequency features. The output is saved as *<ia/if>_<language>_i.txt* (i = ith file)

Run *codes/model/labelling.py* to arrange features for each language file and label them accordingly.

Run *codes/model/language_detection.ipynb* for viewing the results on a simple SVM model

<br>

Comments are added wherever appropriate.

<br>

### Data:
1. Download the data from  https://drive.google.com/drive/folders/1qgM1a-vLCsmMrLv3iJOgOmAyRTwNx7SN
2. Create train_folder, test_folder, dev_folder in the clips folder of each language
3. Copy the file names from each category and save it in a <type>.txt file (example:train.txt).
  
4. Split the train and text from the tsv files using copying.py

<br>

Folder with extracted features and model: https://drive.google.com/drive/folders/1Z8xYeaJzXT3NVaz0tz7ykAz6GwPcfHVs?usp=sharing 
