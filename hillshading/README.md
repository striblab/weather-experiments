# Hillshaded relief maps of snowfall accumulation

Replicating projects from the [Washington Post](https://www.washingtonpost.com/graphics/2018/national/snow-accumulation/?utm_term=.0f13e7b9f5a1) and [Garrett Dash Nelson](http://viewshed.matinic.us/2018/01/13/1139/), which visualize accumulated snowfall across the U.S. as hillshaded contour maps.

Data comes from the [National Weather Service](https://www.nohrsc.noaa.gov/snowfall/).

## Usage

There are a couple different ways to get at this, but both start with running `scrape.py` to download GeoTIFFs from the NWS. You can change the beginning/ending dates in the script to grab whatever range you want.

This will create a directory called `./raw` containing a bunch of GeoTIFFs. There are two ways to process these.

In the `national` directory, you can run `./make.sh` to create a national animated map of those files. Doing the same thing in the `midwest` directory will create a similar map clipped to the upper Midwest.

Feel free to change stuff. The `color-ramp.txt` files define the color scheme. Hillshade relief can be changed with the `-z` parameter on the `gdaldem hillshade` command. Other parameters can also be tuned for different results.

## Todo

  * Try smoothing the pixels on the Midwest map. Looks too blocky zoomed in.
  * Change the color and relief to make the Midwest map more useful/granular
  * Add vector boundaries and labels
  * Optimize file sizes

## Resources

In no particular order:

  * [Derek Watkins' GDAL cheat sheet](https://github.com/dwtkns/gdal-cheat-sheet)
  * [A gentle introduction to GDAL](https://medium.com/planet-stories/a-gentle-introduction-to-gdal-part-1-a3253eb96082)
  * [Making a New York Times map](https://thomasthoren.com/2016/02/28/making-a-new-york-times-map.html)
  * [Creating a transparent hillshade](https://gis.stackexchange.com/)questions/144535/creating-transparent-hillshade/144700#144700)
  * [Smoothing DEM using GRASS](https://gis.stackexchange.com/questions/12833/smoothing-dem-using-grass)
  * [An R-based, colored version of this map](http://strimas.com/r/snowfall/)
  * [GDAL hillshade tutorial](https://github.com/clhenrick/gdal_hillshade_tutorial)
  * [Tilemill guide to terrain data](https://tilemill-project.github.io/tilemill/docs/guides/terrain-data/)
  * [Ways to merge colored relief and shaded relief](http://dirkraffel.com/2011/07/05/best-way-to-merge-color-relief-with-shaded-relief-map/)
  * [A workflow for creating beautiful shaded DEMs using GDAL](https://web.archive.org/web/20120120182050/http://linfiniti.com/2010/12/a-workflow-for-creating-beautiful-relief-shaded-dems-using-gdal/)
  * [Creating hillshades and colored relief maps](https://medium.com/devseed/creating-hillshades-and-color-relief-maps-based-on-srtm-data-for-afghanistan-and-pakistan-ae7c8e85d936)

## Questions?

Contact chase.davis@startribune.com