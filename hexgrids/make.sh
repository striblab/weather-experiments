# Base states file: http://www2.census.gov/geo/tiger/GENZ2017/shp/cb_2017_us_state_500k.zip
# Readme: ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt

unzip cb_2017_us_state_500k.zip

echo 'Making Minnesota basemap ...'
mapshaper -i cb_2017_us_state_500k.shp \
  -quiet \
  -proj latlon \
  -filter 'STUSPS == "MN"' \
  -o format=topojson ./mn-base.json &&
rm cb_2017_us_state_500k.shp.ea.iso.xml && \
rm cb_2017_us_state_500k.shp.iso.xml && \
rm cb_2017_us_state_500k.shp.xml && \
rm cb_2017_us_state_500k.shp && \
rm cb_2017_us_state_500k.shx && \
rm cb_2017_us_state_500k.dbf && \
rm cb_2017_us_state_500k.prj && \
rm cb_2017_us_state_500k.cpg &&

echo 'Making hex grid ...'
node _make_hexgrid.js &&
mapshaper mn-grid.tmp.json \
  -clip mn-base.json \
  -o format=geojson mn-grid.json &&

rm mn-grid.tmp.json &&
rm mn-base.json &&

echo 'Done!'