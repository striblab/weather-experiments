rm -rf tmp && \
rm -rf final && \

mkdir -p tmp && \
mkdir -p final && \
cd ../raw &&

for i in *.tif; do

  # Project the images to Albers
  gdalwarp -q -t_srs "EPSG:102003" -srcnodata "-99999" $i ../midwest/tmp/proj_$i;

  # Clip to bbox
  gdalwarp -q -te -671180.0255125965 280246.31011099846 718505.4205881933 1323895.0091663552 -ts 0 900 -dstalpha -r bilinear ../midwest/tmp/proj_$i ../midwest/tmp/clipped_$i;
  rm ../midwest/tmp/proj_$i;

  # Clip images to midwest
  gdalwarp -q -srcnodata "-99999" -dstnodata "0" -cutline ../midwest/vector/midwest/midwest-base.shp ../midwest/tmp/clipped_$i ../midwest/tmp/cut_$i;
  rm ../midwest/tmp/clipped_$i;

  # Hillshade the snowfall totals
  gdaldem hillshade -z 3000 ../midwest/tmp/cut_$i ../midwest/tmp/hillshade_$i;
  convert -gamma .5 ../midwest/tmp/hillshade_$i ../midwest/tmp/gamma_$i;
  rm ../midwest/tmp/hillshade_$i;

  # Create color relief of snowfall totals
  gdaldem color-relief ../midwest/tmp/cut_$i ../midwest/color-ramp.txt ../midwest/tmp/shadedrelief_$i;
  rm ../midwest/tmp/cut_$i;

  # Combine hillshade and color relief
  convert ../midwest/tmp/shadedrelief_$i ../midwest/tmp/gamma_$i -compose Overlay -composite ../midwest/tmp/colored_$i;

  # Turn into gifs
  convert ../midwest/tmp/colored_$i -resize 50% ../midwest/tmp/$i.gif;
  rm ../midwest/tmp/colored_$i;

done

cd ../midwest/ && \
echo "Converting to animated gif ..." && \
convert -delay 10 -loop 0 ./tmp/*.gif ./final/animated-midwest.gif && \

rm -rf ./tmp
