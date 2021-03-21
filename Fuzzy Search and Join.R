## ----setup, include=FALSE------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----message=FALSE-------------------------------
library(tidyverse)


## ------------------------------------------------
library(tidystringdist)


## ------------------------------------------------
df <- data.frame(stringsAsFactors = FALSE,
  Name = as.factor(c(" CANON PVT. LTD ", " Antila,Thomas ", " Greg ",
                     " St.Luke's Hospital ", " Z_SANDSTONE COOLING LTD ",
                     " St.Luke's Hospital ", " CANON PVT. LTD. ",
                     " SANDSTONE COOLING LTD ", " Greg ", " ANTILA,THOMAS ")),
  City = as.factor(c(" Georgia ", " Georgia ", " Georgia ", " Georgia ",
                     " Georgia ", " Georgia ", " Georgia ", " Georgia ",
                     " Georgia ", " Georgia "))
)


## ------------------------------------------------
df


## ------------------------------------------------
df_sim <- df %>% 
  tidy_comb_all(Name) %>%
  tidy_stringdist()

dim(df_sim)
head(df_sim)


## ------------------------------------------------
df_sim %>% arrange(dl,V1)


## ------------------------------------------------
load("../IEBC_Verification/shiny_app/bbi_verifier/iebc_data_fin.RData")


## ------------------------------------------------
iebc_sample <- iebc_data_fin %>% 
  head(2500) %>% 
  select(BBI_SUPPORTERNAMES) %>% 
  mutate(BBI_SUPPORTERNAMES = str_trim(BBI_SUPPORTERNAMES))


## ------------------------------------------------
iebc_sim <- iebc_sample %>% 
  tidy_comb_all(BBI_SUPPORTERNAMES) %>% 
  tidy_stringdist(method = c("osa","dl"))


## ------------------------------------------------
iebc_sim %>% 
  filter(osa<=1) %>% 
  arrange(V1,osa)


## ------------------------------------------------
library(fuzzyjoin)


## ------------------------------------------------
df_top <- head(df,5)
df_bottom <- tail(df,5)


## ------------------------------------------------
df_top %>% 
  stringdist_left_join(df_bottom, 
                       by = "Name", 
                       method="osa", 
                       distance_col="osa",
                       max_dist=Inf) %>% 
  arrange(osa) %>% 
  filter(osa<=10)


## ------------------------------------------------
tidy_stringdist(df = bind_col(df_top, df_bottom), 
                v1 = Name...1, 
                v2 = Name...3)

