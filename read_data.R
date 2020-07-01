library(dplyr)

csv_ct <- "./downloads/ct.csv"
df_ct <- read.csv(csv_ct)

df_ct <- df_ct %>%
  arrange(desc(Date)) %>% 
  rename(Tests = COVID.19.PCR.tests.reported, Cases = Total.cases, Hospitalized = Hospitalized.cases, Deaths = Total.deaths) %>%
  select(c(Date, Tests, Cases, Hospitalized, Deaths)) 
LEN = dim(df_ct)[1]

New.Tests = df_ct[1:LEN-1, "Tests"] - df_ct[2:LEN, "Tests"]
New.Cases = df_ct[1:LEN-1, "Cases"] - df_ct[2:LEN, "Cases"]
New.Hosp = df_ct[1:LEN-1, "Hospitalized"] - df_ct[2:LEN, "Hospitalized"]
Cases.Growth = New.Cases / (df_ct[2:LEN, "Cases"])

df_changes_ct = data.frame(Date = df_ct[1:LEN-1, "Date"], New.Tests, New.Cases, New.Hosp, Positive = New.Cases/New.Tests, Cases.Growth)

print(head(df_changes_ct, 20))
plot(x = df_changes_ct[, "Date"], y = df_changes_ct[, "New.Cases"])