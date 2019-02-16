#datavizbook visualization challenge

##2/16/19
library(tidyverse)
library(openxlsx)

#url <- "https://ncses.nsf.gov/pubs/nsf19301/assets/data/tables/sed17-sr-tab013.xlsx"

file_name<-"sed17-sr-tab013.csv"
finefield<-read.csv(here("dataviz_challenge", file_name))
names(finefield)

epi <- subset(finefield, subset = Field %in% "Epidemiology")
epi_long <- gather(epi, year, graduates, X2008:X2017, factor_key=TRUE)

g <- ggplot(data = epi_long, mapping=aes(x = year, y= graduates))
g+geom_point(color="gray70") +
  labs(x = "Year", 
       y = "# graduates",
       title ="Epidemiology Doctoral Degrees 2008-2017")+
  theme_bw()

ggsave(here("dataviz_challenge", "epi.png"))