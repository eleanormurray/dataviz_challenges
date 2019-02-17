#datavizbook visualization challenge

##2/16/19
library(tidyverse)
library(here)

#url <- "https://ncses.nsf.gov/pubs/nsf19301/assets/data/tables/sed17-sr-tab013.xlsx"

file_name<-"sed17-sr-tab013.csv"
finefield<-read.csv(here(file_name))
names(finefield)

epi <- subset(finefield, subset = Field %in% "Epidemiology")
epi_long <- gather(epi, year, graduates, X2008:X2017, factor_key=TRUE)

g <- ggplot(data = epi_long, mapping=aes(x = year, y= graduates))
g+geom_point(color="gray70") +
  labs(x = "Year", 
       y = "# graduates",
       title ="Epidemiology Doctoral Degrees 2008-2017")+
  theme_bw()

ggsave(here("epi.png"))

#Suggested improvements
#1. change year to a numeric or date variable
class(epi_long$year)
epi_long$year_c <- as.character(epi_long$year)
epi_long$year_c2 <- substr(epi_long$year_c, 2, nchar(epi_long$year_c))
epi_long$year_num <- as.numeric(epi_long$year_c2)

library(ggrepel)

g <- ggplot(data=epi_long, mapping=aes(x=year_num, y=graduates))
g+geom_point()+
  scale_x_continuous(breaks=c(2008, 2012, 2016), labels = c("2008", "2012", "2016"))+
  labs(x="Year", y = "# graduates", title = "Epidemiology Doctoral Degrees 2008-2017", 
       caption="Data from nsf.gov")+
  theme_bw()

ggsave(here("epi2.png"))