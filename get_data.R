
library(googlesheets4)

if(!file.exists("./downloads"))
  dir.create("./downloads")

url_ct <- "https://data.ct.gov/api/views/rf3k-f8fg/rows.csv?accessType=DOWNLOAD"
csv_ct <- "./downloads/ct.csv"
download.file(url = url_ct, destfile = csv_ct)

url_ri <- "https://docs.google.com/spreadsheets/d/1n-zMS9Al94CPj_Tc3K7Adin-tN9x1RSjjx2UzJ4SV7Q/"
csv_ri <- "./downloads/ri.csv"
RI <- read_sheet(url_ri, sheet = "COVID Trends")
RI$ICU[RI$ICU == "NULL"] <- NA
RI$ICU <- as.numeric(unlist(RI$ICU))

RI$Vented[RI$Vented == "NULL"] <- NA
RI$Vented <- as.numeric(unlist(RI$Vented))

RI <- arrange(RI, desc(Date))

write.csv(RI, file = csv_ri, row.names = TRUE)