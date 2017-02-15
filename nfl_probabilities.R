library(rvest)
library(dplyr)
library(stringr)
library(reshape2)

url <- "http://www.pro-football-reference.com/boxscores/game-scores.htm"

tbl <-  url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="games"]') %>% 
  html_table() 

scores <-  tbl[[1]]

scores <- select(scores, PtsW,PtsL,Count)

scores$PtsW <- as.character(scores$PtsW)

scores$PtsL <- as.character(scores$PtsL)

scores$PtsW <- str_sub(scores$PtsW,start=nchar(scores$PtsW))

scores$PtsL <- str_sub(scores$PtsL,start=nchar(scores$PtsL))

scores <- melt(scores, id.vars="Count")

total <- sum(scores$Count)

probabilities <- scores %>% 
  select(value,Count) %>%
  group_by(value) %>% 
  summarise(chance=round(sum(Count)/total,3))

