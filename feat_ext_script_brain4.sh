# AUTHOR: (Karl) Sangwon Lee
# UPDATED: May 27, 2021

# Bash Script to Apply Feature Extraction Script to .npy probability map Files

# [CHANGE THIS] Path to ZhenZhen's Feature Extraction
feature_ext=/cis/home/slee508/ADproject-master/FeatureExtraction/feature_extraction.py



# only input & output paths have to change for different folders


################# REPEAT (COPY & PASTE & EDIT) THIS CODE BLOCK FOR EACH FOLDER #################

# [CHANGE THIS] Path to Probability Map from applying UNet
inpath="/cis/home/slee508/my_documents/Brain4/prob_map_data/block1/"
# [CHANGE THIS] Path to output assets
outpath="/cis/home/slee508/my_documents/Brain4/asset/block1/"

echo "------------------------------------------------"
echo "New Input Path: " "$inpath"
echo -e "New Output Path: " "$outpath\n"

for file in "$inpath"*.npy

do

files="${file##*/}"
file_name="${files%.*}"
output_name1="Segmented_$file_name"
output_name2="description_$file_name"

echo -e "Input File is: $files\n"
echo "Performing Feature Extraction"


# Submit Feature Extraction Script to the machine. 
nohup python "$feature_ext" "$file" "$outpath$output_name1.npy" "$outpath$output_name2.csv" >/dev/null 2>&1 &

echo "Nohup script submitted"
echo -e "Output 1 will be saved as : $output_name1.npy"
echo -e "Output 2 will be saved as : $output_name2.csv"

done

################# REPEAT (COPY & PASTE & EDIT) THIS CODE BLOCK FOR EACH FOLDER #################





# example of repeat

################# REPEAT (COPY & PASTE & EDIT) THIS CODE BLOCK FOR EACH FOLDER #################

inpath="/cis/home/slee508/my_documents/Brain4/prob_map_data/block2/"
outpath="/cis/home/slee508/my_documents/Brain4/asset/block2/"

echo "------------------------------------------------"
echo "New Input Path: " "$inpath"
echo -e "New Output Path: " "$outpath\n"

for file in "$inpath"*.npy

do

files="${file##*/}"
file_name="${files%.*}"
output_name1="Segmented_$file_name"
output_name2="description_$file_name"

echo -e "Input File is: $files\n"
echo "Performing Feature Extraction"

nohup python "$feature_ext" "$file" "$outpath$output_name1.npy" "$outpath$output_name2.csv" >/dev/null 2>&1 &

echo "Nohup script submitted"
echo -e "Output 1 will be saved as : $output_name1.npy"
echo -e "Output 2 will be saved as : $output_name2.csv"

done

################# REPEAT (COPY & PASTE & EDIT) THIS CODE BLOCK FOR EACH FOLDER #################


