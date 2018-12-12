# Using turf to make hexgrids

Simple set of scripts to programmatically create [hex grids](http://turfjs.org/docs#hexGrid) across geometries, which could be used as bins for visualizing various weather things. You could also use this to create [other type of grids](http://turfjs.org/docs#squareGrid).

## Usage

The `turf.js` code that actually generates the hexgrids is in `_make_hexgrid.js`. Reset the bounds to increase/decrease the size of the grid.

`make.sh` will take that grid and clip it to a geographic boundary, in this case a GeoJSON of Minnesota.

## Todo

  * We could conceivably overlay the NOAA snow data from `../hillshading/` onto a hexgrid or normal grid.
  * [3D bars?](https://pudding.cool/2018/12/3d-cities-story/) Howto doc is [here](https://docs.google.com/document/d/1Us_1QBHShdMe8-laKhGh_mjkXxOw-74-9mxJAx_DvKE/edit).

## Questions

Contact chase.davis@startribune.com
