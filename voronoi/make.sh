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

echo 'Making GHCND layer ...'
cat ./stations/ghcnd-stations.txt | \
  awk -v OFS=, '{ print substr($0, 1, 11),substr($0, 13, 8),substr($0, 23, 8),substr($0, 39, 2),substr($0, 42, 29)}' > ghcnd-stations.tmp.csv && \
  echo "id,lat,lon,state,description" | \
  cat - <(cat ghcnd-stations.tmp.csv) | \
  csv2json |
  ndjson-split |
  ndjson-filter 'd.state == "MN"' | \
  ndjson-map '{"id": d.id.trim(), "lat": d.lat.trim(), "lon": d.lon.trim(), "state": d.state.trim(), "description": d.description.trim()}' | \
  ndjson-reduce | \
  json2csv > ghcnd-stations.csv &&
  rm ghcnd-stations.tmp.csv &&
mapshaper ghcnd-stations.csv \
  -points x=lon y=lat \
  -proj longlat \
  -o ./stations/ghcnd-stations.json format=geojson &&
rm ghcnd-stations.csv &&

echo 'Calculating station Voronoi ...'
node _make_voronoi.js &&
mapshaper ghcnd-voronoi.tmp.json \
  -clip mn-base.json \
  -o format=geojson mn-voronoi.tmp.json &&
rm ghcnd-voronoi.tmp.json &&
mapshaper mn-voronoi.tmp.json \
  -join ./stations/ghcnd-stations.json \
  -o format=geojson mn-voronoi.json &&
rm *.tmp.json &&

rm mn-base.json
