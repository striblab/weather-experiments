rm -rf tmp && \
rm -rf final && \

mkdir -p tmp && \
mkdir -p final && \
cd data && \

x=0
for i in *.nc; do
  # Pull out grayscale cloud layer (c01 or c02)
  gdal_translate -ot float32 -unscale -CO COMPRESS=deflate NETCDF:"$i":CMI_C1 ../tmp/c02.tmp.tif

  # Assign coordinate georeference
  gdalwarp -t_srs EPSG:4326 -dstnodata -999.0 ../tmp/c02.tmp.tif ../tmp/c02.geo.tmp.tif

  # Clip to Midwest
  gdalwarp -q -te -110.5852335794 36.6468069451 -79.37479199 50.7089671985 -ts 0 900 -dstalpha -r bilinear ../tmp/truecolor.corrected.tmp.tif ../tmp/truecolor.clipped.tmp.tif
  
  # Burn boundary lines
  gdal_rasterize -b 1 -burn 0 -l midwest-base-wgs84-lines ../vector/midwest/midwest-base-wgs84-lines.shp ../tmp/c02.clipped.tmp.tif

  # Convert to GIF
  sips -s format png ../tmp/c02.clipped.tmp.tif --out ../tmp/c02.clipped.tmp.png

  # Move to final
  mv ../tmp/c02.clipped.tmp.png ../final/bw.$x.png
  rm ../tmp/*

  x=$((x+1))
done

# Convert to mp4
cd ../final && \
ffmpeg -r 60 -f image2 -s 999x450 -i bw.%d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p output.bw.mp4
rm ./*.png
