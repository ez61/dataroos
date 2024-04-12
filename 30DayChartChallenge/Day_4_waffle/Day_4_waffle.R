library(waffle)
library(dplyr)
library(tidyverse)
library(janitor)


roaddeath <- read.csv("ardd_fatalities.csv", header = TRUE)
head(roaddeath)
tail(roaddeath)

roaddeath_select <- roaddeath |> filter(Month == "10" & Year == "2023")
str(roaddeath_select)

clean_data <- roaddeath_select |> group_by(Road.User) |> summarise(Count = n()) |> 
  arrange(desc(Count)) |> pivot_wider(names_from = Road.User, values_from = Count) |> clean_names()


parts <- data.frame(parts = colnames(clean_data),
                     vals = c(43, 22, 14, 13, 2, 1))



waffle(parts = parts, rows = 5, 
       colors = c('#d73027','#fc8d59','#fee090','#e0f3f8','#91bfdb','#4575b4'),
       legend_pos = "right", title = "Road deaths by user type on Australian roads\nOctober 2023, n=95")

