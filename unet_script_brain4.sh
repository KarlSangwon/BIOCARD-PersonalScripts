# AUTHOR: (Karl) Sangwon Lee
# UPDATED: May 27, 2021

# Bash Script to Apply UNet Script to Tif Files

# [CHANGE THIS] Path to ZhenZhen's UNet apply script
apply=/cis/home/slee508/ADproject-master/unet/apply.py
# [CHANGE THIS] Path to Trained UNet Model
unet=/cis/home/slee508/ADproject-master/unet/asset/unet_tau.pth



# for different folders, only input & output paths have to change.

################# REPEAT (COPY & PASTE & EDIT) THIS CODE BLOCK FOR EACH FOLDER #################

# [CHANGE THIS] Input Path (.tif files) 
inpath="/cis/home/kstouff4/Documents/datasets/exvivohuman_11T/more_blocks/Brain4/histology/down_000/AD_Hip1/Tau/"
# [CHANGE THIS] Output Path (.npy files)
outpath="/cis/home/slee508/my_documents/Brain4/prob_map_data/block1/"

echo "------------------------------------------------"
echo "New Input Path: " "$inpath"
echo -e "New Output Path: " "$outpath\n"

for file in "$inpath"*crop.tif

do

files="${file##*/}"
file_name="${files%.*}"
output_name="pmap_$file_name"

echo -e "Input File is: $files\n"
echo "Applying UNET"
python "$apply" "$file" "$unet" "$outpath$output_name.npy"

echo -e "Output Probability Map Saved as: $output_name.npy\n"

done

################# REPEAT (COPY & PASTE & EDIT) THIS CODE BLOCK FOR EACH FOLDER #################




# example of repeat (for block 2)

################# REPEAT (COPY & PASTE & EDIT) THIS CODE BLOCK FOR EACH FOLDER #################

inpath="/cis/home/kstouff4/Documents/datasets/exvivohuman_11T/more_blocks/Brain4/histology/down_000/AD_Hip2/Tau/"
outpath="/cis/home/slee508/my_documents/Brain4/prob_map_data/block2/"

echo "------------------------------------------------"
echo "New Input Path: " "$inpath"
echo -e "New Output Path: " "$outpath\n"

for file in "$inpath"*crop.tif

do

files="${file##*/}"
file_name="${files%.*}"
output_name="pmap_$file_name"

echo -e "Input File is: $files\n"
echo "Applying UNET"
python "$apply" "$file" "$unet" "$outpath$output_name.npy"

echo -e "Output Probability Map Saved as: $output_name.npy\n"

done

################# REPEAT (COPY & PASTE & EDIT) THIS CODE BLOCK FOR EACH FOLDER #################

