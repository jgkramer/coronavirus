
if(!file.exists("./downloads"))
  dir.create("./downloads")

url_ct <- "https://data.ct.gov/api/views/rf3k-f8fg/rows.csv?accessType=DOWNLOAD"
csv_ct <- "./downloads/ct.csv"
download.file(url = url_ct, destfile = csv_ct)
