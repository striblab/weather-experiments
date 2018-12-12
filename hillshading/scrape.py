from datetime import timedelta, date
import urllib

def daterange(start_date, end_date):
    for n in range(int ((end_date - start_date).days)):
        yield start_date + timedelta(n)

start_date = date(2017, 10, 1)
end_date = date(2018, 4, 30)
n = 0

for single_date in daterange(start_date, end_date):
    print single_date.strftime("%Y%m%d")
    fileToGet = "sfav2_CONUS_2017093012_to_{}12.tif".format(single_date.strftime("%Y%m%d"))
    urlToGet = "http://www.nohrsc.noaa.gov/snowfall/data/{}/".format(single_date.strftime("%Y%m"))+fileToGet

    pad = format(n, '04')
    urllib.urlretrieve (urlToGet, "./raw/{}-{}".format(pad,fileToGet))
    n = n + 1
