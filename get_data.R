
library(googlesheets4)
library(stringr)
library(dplyr)

if(!file.exists("./downloads"))
  dir.create("./downloads")

if(!file.exists("./downloads/mass"))
  dir.create("./downloads/mass")

#CONNECTICUT
url_ct <- "https://data.ct.gov/api/views/rf3k-f8fg/rows.csv?accessType=DOWNLOAD"
csv_ct <- "./downloads/ct.csv"
download.file(url = url_ct, destfile = csv_ct)


#RHODE ISLAND
url_ri <- "https://docs.google.com/spreadsheets/d/1n-zMS9Al94CPj_Tc3K7Adin-tN9x1RSjjx2UzJ4SV7Q/"
csv_ri <- "./downloads/ri.csv"
RI <- read_sheet(url_ri, sheet = "COVID Trends")
RI$ICU[RI$ICU == "NULL"] <- NA
RI$ICU <- as.numeric(unlist(RI$ICU))

RI$Vented[RI$Vented == "NULL"] <- NA
RI$Vented <- as.numeric(unlist(RI$Vented))
RI <- arrange(RI, desc(Date))

write.csv(RI, file = csv_ri, row.names = TRUE)

#MASS
url_ma_scrape <- "https://www.mass.gov/info-details/covid-19-response-reporting"
landingPage <- readLines(url_ma_scrape)
matches <- str_match(landingPage, "/doc/covid-19-raw-data-.*/download")
url_ma_data <- paste("https://www.mass.gov", matches[!is.na(matches)], sep="")


today_dir <- paste("./downloads/mass/", Sys.Date(), sep="")
download.file(url_ma_data, "./downloads/mass/mass.zip", mode="wb")
unzip("./downloads/mass/mass.zip", exdir = today_dir)
