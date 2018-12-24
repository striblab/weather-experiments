# Gets daytime GOES-16 data from the blizzard of April 14, 2008

# Day IDs that GOES-16 recognizes. 104 is the 14th. 105 is the 15th. Need
# both because data stored is in UTC time, which is six hours ahead of us.
DAY_START=103
DAY_END=104

for i in $(seq -f "%03g" $DAY_START $DAY_END); do

  if [ $i -eq 103 ]
  then
    for j in $(seq -f "%02g" 0 23); do
      echo 'Cloning' https://noaa-goes16.s3.amazonaws.com/ABI-L2-MCMIPC/2018/$i/$j/ '...' &&
      rclone copy publicAWS:noaa-goes16/ABI-L2-MCMIPC/2018/$i/$j/ ./data
    done
  fi

  if [ $i -eq 104 ]
  then
    for j in $(seq -f "%02g" 0 11); do
      echo 'Cloning' https://noaa-goes16.s3.amazonaws.com/ABI-L2-MCMIPC/2018/$i/$j/ '...' &&
      rclone copy publicAWS:noaa-goes16/ABI-L2-MCMIPC/2018/$i/$j/ ./data
    done
  fi

done
