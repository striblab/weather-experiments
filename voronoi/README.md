## Weather station Voronoi

Uses [turf](http://turfjs.org) and other tools to create a [Voronoi map](https://en.wikipedia.org/wiki/Voronoi_diagram) of official and volunteer weather stations in Minnesota.

Could be useful in assigning observations from [GHCN stations](https://www.ncdc.noaa.gov/data-access/land-based-station-data/land-based-datasets/global-historical-climatology-network-ghcn) to surrounding areas. As far as I can tell, station data is the longest-running historical source of weather data available, so this could be useful if we have to map stuff from way back in history.

## Usage

The `turf.js` code that actually generates the voronoi is in `_make_voronoi.js`. It relies on the station data in `./stations`, which comes from [NOAA](ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt).

`make.sh` combines that voronoi with a Minnesota basemap.

## Todo

  * Stations seem to have really inconsistent observations. Do some go back in time consistently?
  * Figure out how this is useful ...

## Questions

Contact chase.davis@startribune.com