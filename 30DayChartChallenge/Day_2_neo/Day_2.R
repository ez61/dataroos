#30day challenge
# Day 2: neo
# Data source: Wikipedia, Airbus
#library(dplyr)
library(ggplot2)
library(timelineS)
library(grid) 
library(scales)
library(magick)
library(gridExtra)

a320neo <- read.csv("Day_2_A320neo_family.csv", header = TRUE)

str(a320neo)
a320neo$Events <- as.factor(a320neo$Events)
a320neo$Event_Dates <- as.Date(a320neo$Event_Dates)


png("timelineS_plot.png",width = 2000, height = 2000, res = 300)
timelineS(a320neo, "A320 / A320neo family 1st flight", buffer.days = 900,
          label.color = "#091C59", pch = 20, point.color = "maroon")

dev.off()


a320neo_range <- read.csv("Day_2_A320neo_family_range.csv", header = TRUE)
head(a320neo_range)

a319neo_image <- png::readPNG('A319neo.png')
a320neo_image <- png::readPNG('A320neo.png')
a321neo_image <- png::readPNG('A321neo.png')

# Convert images to 'grob' objects
aspect_ratio <- 480 / 280
a319neo_grob <- rasterGrob(a319neo_image, width=unit(1,"npc"), height=unit(aspect_ratio,"npc"))
a320neo_grob <- rasterGrob(a320neo_image, width=unit(1,"npc"), height=unit(aspect_ratio,"npc"))
a321neo_grob <- rasterGrob(a321neo_image, width=unit(1,"npc"), height=unit(aspect_ratio,"npc"))

a320neo_range$label <- paste0(format(prettyNum(a320neo_range$range, big.mark = ",")), " km")


p <- ggplot(a320neo_range, aes(x=aircraft, y=range, label = label)) +
  geom_col(width=0.5, fill = "skyblue") +
  geom_text(position=position_stack(vjust=0.5),
            color="white", size=4.5, fontface = "bold") +
  labs(x = "", y = "Range (kilometres)", title = "A320neo family range")+
  scale_y_continuous(labels = label_comma(), limits = c(0, 8000))+
  theme(panel.background = element_rect(fill="#FFFFFF", colour = NA),
        panel.grid = element_blank(),
        axis.line.x = element_line(colour = "grey50"),
        axis.line.y = element_line(colour = "grey50"),
        axis.text.x = element_text(size = 12),
        axis.ticks.x = element_blank(),
        plot.margin = margin(t = 5, r = 5, b = 5, l = 5, unit = "pt")) 

# Add the images as annotations

p2 <- p + annotation_custom(grob=a319neo_grob, xmin=0.2, xmax=1.8, ymin = 4930, ymax=6330)+ # adjust these values
  annotation_custom(a320neo_grob, xmin=1.2, xmax=2.8, ymin = 4380, ymax=5780) +
  annotation_custom(a321neo_grob, xmin=2.2, xmax=3.8, ymin = 5500, ymax=6900)


ggsave("p2.png", p2, width = 6.7, height = 6.7, dpi = 300)

timelineS_img <- image_read("timelineS_plot.png")
ggplot2_img <- image_read("p2.png")


timelineS_grob <- rasterGrob(as.raster(timelineS_img), interpolate = TRUE)
ggplot2_grob <- rasterGrob(as.raster(ggplot2_img), interpolate = TRUE)

# Combine the images using grid.arrange
combined_plot <- grid.arrange(timelineS_grob, ggplot2_grob, ncol = 2)
combined_plot
grid.draw(combined_plot)
