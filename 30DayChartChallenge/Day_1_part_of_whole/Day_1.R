#30day challenge
# Day 1: part-to-whole
# https://www.aph.gov.au/Senators_and_Members/Parliamentarian_Search_Results?q=&mem=1&par=-1&gen=0&ps=0
library(ggparliament)
library(dplyr)
library(ggplot2)


election_data |> head()

election_data |> filter(country == "Australia")

aus_rep <- read.csv("parliament_australia.csv", header = TRUE)
head(aus_rep)
aus_rep_horseshoe <- parliament_data(aus_rep,
                                     parl_rows = 5,
                                     party_seats = aus_rep$seats,
                                     type = "horseshoe")
aus_rep_horseshoe


aus_par <- ggplot(aus_rep_horseshoe, aes(x = x, y = y, colour = party_short)) +
  geom_parliament_seats(size = 4) + 
  geom_highlight_government(government == 1, colour = "white", size = 4, stroke = 2)+ 
  #theme_ggparliament(background_colour = TRUE) +
  labs(colour = "Party", 
       title = "The Australian House of Representatives", 
       subtitle = "(As of 2 Apr 2024)") +
  scale_colour_manual(values = aus_rep_horseshoe$colour, 
                      limits = aus_rep_horseshoe$party_short) +
  #theme_ggparliament()
  theme_void() +
  theme(legend.title = element_text(size = 12, face = "bold"),
        legend.text = element_text(size = 10),
        panel.background = element_rect(fill="grey90", colour = NA),
        #legend.position = c(0.97, 0.97), # Top-right corner
        legend.position = "right",
        legend.justification = "top",
        legend.key = element_rect(fill = NA, colour = NA), 
        legend.margin = margin(t = 10, r = 10, b = 10, l = -3, unit = "pt"),
        plot.margin = margin(t = 5, r = 5, b = 5, l = 5, unit = "pt")) 
aus_par

