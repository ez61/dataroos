library(ggplot2)
library(ggrepel)
library(sf)
library(dplyr)
library(ggspatial)

aus_spdf <- st_read("STE_2021_AUST_SHP_GDA2020/STE_2021_AUST_GDA2020.shp")

gg <- ggplot() +
  geom_sf(data = aus_spdf, fill = "white", 
          color = "lightblue", linewidth = 0.25)

maritimeport <- read.csv("Major_Maritime_Ports.csv", header = TRUE)

maritimeport <- maritimeport |> 
  select(class, name, longitude, latitude)

final_plot <- gg + 
  geom_point(data = maritimeport, 
             aes(x = longitude, y = latitude, color = class), 
             size = 2, alpha = 0.8) +
  geom_text_repel(data = maritimeport, 
                  aes(x = longitude, y = latitude, label = name, color = class),
                  box.padding = 0.5, point.padding = 0.5, 
                  max.overlaps = Inf, show.legend = FALSE,
                  size = 2.7, segment.color = 'grey50') +
  scale_color_manual(values = c("Commodity" = "black", 
                                "Commodity/Military" = "maroon")) +
  labs(color = "Port Classification") +  
  theme_void() +
  theme(legend.title = element_text(size = 12, face = "bold"),
        legend.text = element_text(size = 10),
        panel.background = element_rect(fill="lightblue", colour = NA),
        legend.position = c(0.97, 0.97), # Top-right corner
        legend.justification = c("right", "top")) +
  labs(title = "Maritime ports in Australia", 
       colour = "Port class")+
  annotation_scale(location = "br", 
                   width_hint = 0.04, 
                   bar_cols = "black", 
                   height = unit(0.11, "cm"))
