rm -rf tmp && \
rm -rf final && \

mkdir -p tmp && \
mkdir -p final && \
cd data &&

# True color? https://medium.com/planet-stories/a-gentle-introduction-to-gdal-part-4-working-with-satellite-data-d3835b5e2971

for i in *.nc; do
  # Pull out R, B and veggie layers
  gdal_translate -ot float32 -unscale -CO COMPRESS=deflate NETCDF:"$i":CMI_C01 ../tmp/c01.tmp.tif
  gdal_translate -ot float32 -unscale -CO COMPRESS=deflate NETCDF:"$i":CMI_C02 ../tmp/c02.tmp.tif
  gdal_translate -ot float32 -unscale -CO COMPRESS=deflate NETCDF:"$i":CMI_C03 ../tmp/c03.tmp.tif

  # Merge layers. Order matters here (2, 3 then 1)
  gdal_merge.py -o ../tmp/rgb.tmp.tif -separate ../tmp/c02.tmp.tif ../tmp/c03.tmp.tif ../tmp/c01.tmp.tif -co PHOTOMETRIC=RGB -co COMPRESS=DEFLATE

  # Assign coordinate georeference
  gdalwarp -t_srs EPSG:4326 -dstnodata -999.0 ../tmp/rgb.tmp.tif ../tmp/rgb.geo.tmp.tif

  # Clip to Midwest
  gdalwarp -q -te -104.057 39.99 -86.805 49.38 -ts 0 900 -dstalpha -r bilinear ../tmp/rgb.geo.tmp.tif ../tmp/rgb.clipped.tmp.tif
  
  # Burn boundary lines
  gdal_rasterize -b 1 -b 2 -b 3 -burn 0 -burn 0 -burn 0 -l midwest-base-wgs84-lines ../vector/midwest/midwest-base-wgs84-lines.shp ../tmp/rgb.clipped.tmp.tif


done