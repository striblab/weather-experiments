# Animated satellite maps

This example maps several days cloud movement during the blizzard of April 13-15, 2018, using [GOES-16 satellite imagery](http://occ-data.org/GOES-16/).

Could be used to generate animations of interesting storms or weather patterns. Satellite data is most easily downloaded [here](http://home.chpc.utah.edu/~u0553130/Brian_Blaylock/cgi-bin/goes16_download.cgi).

## Usage

First run `get_data.sh` to download a bunch of satellite images using `rclone`. This will take a while, and you'll need to set things up using [these instructions](https://github.com/blaylockbk/pyBKB_v3/blob/master/rclone_howto.md) if it's your first time. Once the data is downloaded, `color.sh` will stitch a bunch of images into a rough movie of the storm. It could use some adjustments in terms of contrast, gamma, etc., but the results should be reasonably clean for a first pass.

## Dependencies

Ooooooh boy. Get ready for it.

The big dependency for working with this stuff is [GDAL](http://edc.occ-data.org/goes16/gdal/). But not just any GDAL. You need GDAL that can also work with NetCDF files, which can only be installed by following [obscure incantations](https://varunpant.com/posts/gdal-2-on-mac-with-homebrew).

You'll also need ffmpeg to make movies (`brew install ffmpeg`) and imagemagick to handle image conversion.

## Notes

Working with satellite images seems to require knowing a bunch of obscure factoids about how satellites work. Some random important things to know are:

  * Data is natively represented in raster form using NetCDF files, which are like special GeoTIFFs for scientists. These can easily be converted to normal GeoTIFFs [using GDAL](http://edc.occ-data.org/goes16/gdal/).
  * The native satellite projection is weird because images are taken from spaaaaaace. Directions for projecting the images into a more familiar form are [here](http://edc.occ-data.org/goes16/gdal/). Once you project the data into something sensible, you can manipulate it as you would other GIS files.
  * The data we want is from the CONUS (Continental US) dataset, not the Full Disk dataset, which is huge.
  * Examples here work with multi-band files (AKA "ABI L2 Cloud and Moisture Imagery: Multi-Band Format"), which encode all of GOES-16's individual bands into a single file. Descriptions of those bands are here, but the most important ones for this are Blue (Band 2), Red (Band 1) and veggie (Band 3) — which can be converted into a faux green band for the purposes of creating true-color imagery (see instructions in `plot_conus.py`).

## Todo

These examples are the barest possible representations of animated satellite data, so future work should be focused on making it look sharper. This includes:

  * Making gamma and contrast adjustments and otherwise sharpening the results
  * Potentially trying to use higher resolution imagery so the zoomed-in version doesn't look so blocky. (Test :Rad files and see if this helps)
  * Labels?

## Resources

In no particular order:

  - [GOES-16 band reference guide](https://www.weather.gov/media/crp/GOES_16_Guides_FINALBIS.pdf)
  - [Manipulated GOES-16 data with GDAL](http://edc.occ-data.org/goes16/gdal)
  - [GOES-16 S3 explorer](https://noaa-goes16.s3.amazonaws.com/index.html)
  - [Conquering the Earth with cron](https://hackaday.com/2018/06/25/conquering-the-earth-with-cron/)
  - [GOES-16 Product Manipulation Using Free Software Tools](https://geonetcast.wordpress.com/2017/02/08/goes-16-product-manipulation-using-free-software-tools/)
  - [Mapping GOES-16 data (notebook)](https://github.com/blaylockbk/pyBKB_v2/blob/master/BB_goes16/mapping_GOES16_data.ipynb)
  - [GOES imagery viewer](https://www.ssec.wisc.edu/data/geo/#/about?satellite=goes-16&end_datetime=latest&n_images=1&coverage=conus&channel=02&image_quality=gif&anim_method=javascript)
  - [Source: How we made Billions of Birds Migrate](https://source.opennews.org/articles/how-we-made-billions-birds-migrate/)
  - [NICAR 18 data blitz](https://github.com/jmuyskens/nicar18-data-blitz-goes-16)
  - [Manipulating GOES-16 data with Python](https://geonetcast.wordpress.com/2017/08/18/geonetclass-manipulating-goes-16-data-with-python-part-vii/)
  - [Some useful stuff from Iowa State](https://mesonet.agron.iastate.edu/GIS/goes.phtml)

## Questions?

Contact chase.davis@startribune.com