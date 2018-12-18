rm -rf tmp && \
rm -rf final && \

mkdir -p tmp && \
mkdir -p final && \
cd data && \

x=0
for i in *.nc; do
  # Pull out grayscale cloud layer (c01 or c02)
  gdal_translate -ot float32 -unscale -CO COMPRESS=deflate NETCDF:"$i":CMI_C02 ../tmp/c02.tmp.tif

  # Assign coordinate georeference
  gdalwarp -t_srs EPSG:4326 -dstnodata -999.0 ../tmp/c02.tmp.tif ../tmp/c02.geo.tmp.tif

  # Clip to Midwest
  gdalwarp -q -te -104.057 39.99 -86.805 49.38 -ts 0 900 -dstalpha -r bilinear ../tmp/c02.geo.tmp.tif ../tmp/c02.clipped.tmp.tif
  
  # Burn boundary lines
  gdal_rasterize -b 1 -burn 0 -l midwest-base-wgs84-lines ../vector/midwest/midwest-base-wgs84-lines.shp ../tmp/c02.clipped.tmp.tif

  # Convert to GIF
  sips -s format png ../tmp/c02.clipped.tmp.tif --out ../tmp/c02.clipped.tmp.png

  # Move to final
  mv ../tmp/c02.clipped.tmp.png ../final/bw.$x.png
  rm ../tmp/*

  x=$((x+1))
done

# Convert to GIF
cd ../final && \
ffmpeg -i bw.%d.png output.gif
rm ./*.png
