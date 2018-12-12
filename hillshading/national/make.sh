rm -rf tmp && \
rm -rf final && \

mkdir -p tmp && \
mkdir -p final && \
cd ../raw &&

for i in *.tif; do

  # Project the images to Albers
  gdalwarp -q -t_srs "EPSG:102003" -srcnodata "-99999" $i ../national/tmp/proj_$i;

  # Hillshade the snowfall totals
  gdaldem hillshade -z 3000 ../national/tmp/proj_$i ../national/tmp/hillshade_$i;
  convert -gamma .5 ../national/tmp/hillshade_$i ../national/tmp/gamma_$i;
  rm ../national/tmp/hillshade_$i;

  # Create color relief of snowfall totals
  gdaldem color-relief ../national/tmp/proj_$i ../national/color-ramp.txt ../national/tmp/shadedrelief_$i;
  rm ../national/tmp/proj_$i;

  # Combine hillshade and color relief
  convert ../national/tmp/shadedrelief_$i ../national/tmp/gamma_$i -compose Overlay -composite ../national/tmp/colored_$i;

  # Turn into gifs
  convert ../national/tmp/colored_$i -resize 50% ../national/tmp/$i.gif;
  rm ../national/tmp/colored_$i;

done

cd ../national/ && \
echo "Converting to animated gif ..." && \
convert -delay 10 -loop 0 ./tmp/*.gif ./final/animated-national.gif && \

rm -rf ./tmp