# AUTHOR: (Karl) Sangwon Lee
# UPDATED: May 27, 2021

#### This bash script is used together with cziToTif python script.

#### Name or Path to the python script.
f=cziToTif_v01.py
tmp=$(mktemp)


# Brain 4 as Example

################ REPEAT THIS CODE BLOCK FOR EACH FOLDER ################

#### Path for your input file folder (raw .czi)
inpath="/cis/home/zhou/Share/HRMRI/Histology/Brain4/Block 3/6E10/"
#### Path for your desired output folder (output .tif)
outpath="/cis/home/kstouff4/Documents/datasets/exvivohuman_11T/more_blocks/Brain4/histology/down_000/AD_Hip3/Amyloid/"

# removes old path in line 23
sed '23d' "$f" > "$tmp" && mv "$tmp" "$f" 

echo "Changing Path"
echo "New Input Path: " "$inpath"
echo "New Output Path: " "$outpath"

# inserts new path in line 23
sed "23i outpath = '$outpath'" "$f" > "$tmp" && mv "$tmp" "$f"

for file in "$inpath"*.czi
do

echo "Converting: "$file

#### Running conversion script for each file
/cis/home/slee508/Fiji.app/ImageJ-linux64 --ij2 --headless --console --run cziToTif_v01.py "FILENAME='$file'"

done

################ REPEAT THIS CODE BLOCK FOR EACH FOLDER ################
