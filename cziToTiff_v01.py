# @File(label = "Image File", persist= false) FILENAME
# @OUTPUT String FILENAME
# @UIService uiService
# @LogService log


import os
import sys
from loci.formats import MetadataTools
from loci.formats import ImageReader
from loci.plugins.out import Exporter
from loci.plugins import LociExporter
from loci.plugins. in import ImporterOptions
from loci.plugins.util import LociPrefs
from loci.plugins import BF
from loci.formats. in import ZeissCZIReader
from loci.formats. in import DynamicMetadataOptions
from ij import IJ, ImagePlus, ImageStack, Prefs
from ij.measure import Calibration
#from org.scijava.log import LogLevel


outpath = '/cis/home/slee508/my_documents/converted_sample/'


def setCZIReaderOptions(imagefile, czi_options, setflatres=True):

        czireader = ZeissCZIReader()
        czireader.setFlattenedResolutions(setflatres)
        czireader.setMetadataOptions(czi_options)
        czireader.setId(imagefile)

        return czireader


def setReaderOptions(imagefile, stitchtiles=False,
                                    setflatres=True,
                                    setconcat=False,
                                    openallseries=False,
                                    showomexml=False,
                                    attach=False,
                                    autoscale=True,
                                    stackformat="Hyperstack",
                                    stackorder="XYCZT",
                                    colormode="Default"):

        czi_options = DynamicMetadataOptions()
        czi_options.setBoolean("zeissczi.autostitch", stitchtiles)
        czi_options.setBoolean("zeissczi.attachments", attach)

        # set the option for the CZIReader
        czireader = setCZIReaderOptions(imagefile, czi_options, setflatres=setflatres)

        # Set the preferences in the ImageJ plugin
        # Note although these preferences are applied, they are not refreshed in the UI
        Prefs.set("bioformats.zeissczi.allow.autostitch", str(stitchtiles).lower())
        Prefs.set("bioformats.zeissczi.include.attachments", str(attach).lower())

        # set the option for the BioFormats import
        reader_options = ImporterOptions()
        reader_options.setOpenAllSeries(openallseries)
        reader_options.setShowOMEXML(showomexml)
        reader_options.setConcatenate(setconcat)
        reader_options.setAutoscale(autoscale)
        reader_options.setStitchTiles(stitchtiles)
        reader_options.setId(imagefile)
        reader_options.setStackFormat(stackformat)
        reader_options.setStackOrder(stackorder)

        return reader_options, czireader



# get the FILENAME as string
imagefile = FILENAME.toString()


# get the output file name base without suffix and path
outname = os.path.basename(imagefile).split('.')[0]

pylevel = 0

# define the reader options
reader_options, czireader = setReaderOptions(imagefile, stitchtiles=True,
                                                        setflatres=False,
                                                        setconcat=True,
                                                        openallseries=False,
                                                        showomexml=False,
                                                        attach=False,
                                                        autoscale=True,
                                                        stackformat="Hyperstack",
                                                        stackorder="XYCZT",
                                                        colormode="Default"
                                                        )

# open the ImgPlus using BioFormats
imps = BF.openImagePlus(reader_options)

# get the series
imp = imps[pylevel]

# close czireader
czireader.close()



#IJ.run(imp, "Stack to RGB","") # this line does not apply correctly. Disregard it.
IJ.run(imp, "Make Composite", "")
IJ.run(imp, "RGB Color","")


paramstring = "outfile=["+ outpath + outname +  ".tif" +"] windowless=true compression=Uncompressed saveROI=false"
plugin = LociExporter()
plugin.arg = paramstring
exporter = Exporter(plugin, imp)
exporter.run()


# get the stack and some info
imgstack = imp.getImageStack()
slices = imgstack.getSize()
width = imgstack.getWidth()
height = imgstack.getHeight()

print( '---------------------------------------------')
print('Filename : ' + imagefile)
print( 'Slices   : ' + str(slices))
print( 'Width    : ' + str(width))
print( 'Height   : ' + str(height))
print( 'Done.')
print( 'Saved as : ' + outname + '.tif')


# exit
os._exit()



# AUTHOR: (Karl) Sangwon Lee
# UPDATED: May 27, 2021

# to run it use with your respective (!) paths:
# ImageJ-linux64 --ij2 --headless --console --run "path/to/script/cziToTiff_v01.py" "FILENAME='path/to/file/data.czi'"

# or if the script should really exit (this trick I was told by Curtis Rueden a long time ago ...) you should
# us the complete commandline, which one can get using: ImageJ-win64.exe --dry-run --ij2 --headless --console
#
# java -Dpython.cachedir.skip=true -Dplugins.dir=C:\\Fiji -Xmx24446m -Djava.awt.headless=true -Dapple.awt.UIElement=true -Xincgc -XX:PermSize=128m -Djava.class.path=C:\\Fiji/jars/imagej-launcher-5.0.3.jar -Dimagej.dir=C:\\Fiji -Dij.dir=C:\\Users\\m1srh\\DOCUME~1\\Fiji -Dfiji.dir=C:\\Fiji -Dfiji.defaultLibPath=bin/server/jvm.dll -Dfiji.executable=C:\\Fiji\\ImageJ-win64.exe -Dij.executable=C:\\Fiji\\ImageJ-win64.exe -Djava.library.path=C:\\Fiji/lib/win64;C:\\Fiji/mm/win64 -Dscijava.context.strict=false net.imagej.launcher.ClassLauncher -ijjarpath jars -ijjarpath plugins net.imagej.Main --run "C:\Fiji\scripts\czireader_headless.py" "FILENAME='C:\Testdata_Zeiss\CellDivision_T=3_Z=5_CH=2_X=240_X=170.czi'"
