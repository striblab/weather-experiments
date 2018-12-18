# Base states file: http://www2.census.gov/geo/tiger/GENZ2017/shp/cb_2017_us_state_500k.zip
# Readme: ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt

unzip cb_2017_us_state_500k.zip

echo 'Making state basemap ...'
mapshaper -i cb_2017_us_state_500k.shp \
  -quiet \
  -proj latlon \
  -o format=topojson ./us-base.json &&
rm cb_2017_us_state_500k.shp.ea.iso.xml && \
rm cb_2017_us_state_500k.shp.iso.xml && \
rm cb_2017_us_state_500k.shp.xml && \
rm cb_2017_us_state_500k.shp && \
rm cb_2017_us_state_500k.shx && \
rm cb_2017_us_state_500k.dbf && \
rm cb_2017_us_state_500k.prj && \
rm cb_2017_us_state_500k.cpg &&

echo 'Done!'

gdal_rasterize -b 1 -i -burn 32678 -l cb_2017_us_state_500k ./us-map/cb_2017_us_state_500k.shp ./data/sample.tif