# BIOCARD-PersonalScripts
AUTHOR: (Karl) Sangwon Lee<br />
UPDATED: May 27, 2021<br />

Scritps Written for BIOCARD Project at Miller/Tward Lab


# Description


## cziToTiff_v01.py

This is a czi-tif conversion script that reads a .czi image, stack its RGB channel, and export it as tiff file.<br />

Previously, BIOFORMAT importers were unable to read .czi image in headless console mode due to its inherent incapability.<br />

This script bypasses it using a unique CZI reader library within the script.<br />

Resulting .tif file is about half the file size of .czi file, while keeping the resolution the same.<br />

Thanks to sebi06 from Carl-Zeiss Microscopy for the help with this script.<br />


<br /><br /><br /><br />
## cziToTiff.sh

This is a bash shell script written to automate applying of czi conversion to all .czi files within a directory.<br />

The thing is, ImageJ is not so nice in that headless mode script seems unable to take more than one input parameter.<br />

Meaning, the user could not specify input directory AND output directory.<br />

This script is written to bypass that by directly editing the script using bash commands. Quite primitive - but it works.<br />

Repeat the code block indicated in the bash script and edit the path to apply conversion to multiple folders. <br />


<br /><br /><br /><br />
## unet_script_brain4.sh

This is a bash shell script written to automate applying of ZhenZhen's UNet apply.py to all .tif files within a directory.<br />

I suggest using the following shell command to use this:<br />

nohup ./unet_script_brain4.sh &<br />


This will run the shell script in background. <br />

It seems that you cannot run pytorch sessions in parallel (maybe there's a way?), so what I am doing here is running one unet after another via this script.<br />

Similar to the shell script above, repeat the code block indicated to apply unet to multiple folders.<br />


brain4 is just an arbitrary naming. I copied the same script and made it brain5, brain6, etc so thath I would not have to edit same file over for different brains.<br />

<br /><br /><br /><br />
## feat_ext_brain4.sh

This is a bash shell script written to automate applying of ZhenZhen's feature extraction to all .npy probability map files within a directory.<br />

This will submit all feature extractions for each file together, and they will run in parallel.<br />

Feature extraction takes a long time, depending on the number of tau particles and number of files. It could take as long as 7 days or more if lots of files.<br />

To monitor your script process in shell, use the following:<br />

ps -aux<br />


This will show all the running processes, and you should be able to find rows of feature extraction running for your user node.<br /><br /><br /><br />





Feel free to email me (slee508@jhu.edu) for any questions regarding the scripts<br />

