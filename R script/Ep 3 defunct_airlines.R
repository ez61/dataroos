# Load the rvest package
library(rvest)
library(dplyr)

# Set the Wikipedia page URL
url <- "https://en.wikipedia.org/wiki/List_of_defunct_airlines_of_Australia"

# Read the HTML content of the page
page <- read_html(url)

# Extract tables from the HTML content
tables <- html_table(page)

# Access the desired table
my_table <- tables[[1]]

colnames(my_table) <- c("Airline", "Image", "IATA", "ICAO", "Callsign",
                        "Commenced", "Ceased", "Notes", "Other")

head(my_table)
final_data <- my_table |> 
  filter(grepl('^[0-9]+$', Commenced), grepl('^[0-9]+$', Ceased)) |> 
  select(Airline, Commenced, Ceased)

str(final_data)

final_data$Commenced <- as.numeric(final_data$Commenced)
final_data$Ceased <- as.numeric(final_data$Ceased)

final_data <- final_data |> 
  mutate(Duration = Ceased - Commenced) |> 
  filter(Duration >= 10) |> 
  mutate(DurationGroup = case_when(
    Duration < 15 ~ "10 to 15 years",
    Duration < 20 ~ "15 to 20 years",
    Duration < 30 ~ "20 to 30 years",
    Duration < 40 ~ "30 to 40 years",
    Duration < 50 ~ "40 to 50 years",
    Duration < 70 ~ "50 to 70 years"
  ))

final_data$DurationGroup <- factor(final_data$DurationGroup, levels = c("10 to 15 years", "15 to 20 years", 
                                                        "20 to 30 years", "30 to 40 years", "40 to 50 years", "50 to 70 years"))

library(ggplot2)
library(cowplot)
ggplot(final_data, 
            aes(x = Commenced, xend = Ceased, 
                y = reorder(Airline, -as.numeric(DurationGroup)), yend = reorder(Airline, -as.numeric(DurationGroup)))) +
  geom_segment(aes(colour = DurationGroup), size = 1.1) +  # Draw lines for the operation period
  geom_point(aes(x = Commenced), color = "#4575b4", size = 0.5) +  # Dots at the commencement
  geom_point(aes(x = Ceased), color = "#f46d43", size = 0.5)+
  scale_colour_manual(values = c(
    "10 to 15 years" = "#c51b7d",
    "15 to 20 years" = "#e9a3c9",
    "20 to 30 years" = "#fde0ef",
    "30 to 40 years" = "#b8e186",
    "40 to 50 years" = "#4d9221",
    "50 to 70 years" = "#276419"),
    name = "Years of operation"
  )+
  #geom_text(aes(x = Ceased, label = paste(Duration, "yr")), hjust = -0.1, vjust = 0.5, color = "black", size.unit = "pt", size = 5)+
  labs(y = "Airline", caption = "List of defunct airlines of Australia\nSource: Wikipedia")+
  theme_cowplot(font_size = 6)+
  facet_wrap(~DurationGroup, scales = "free_y")
  #theme(legend.title = element_text())+
  #facet_wrap(~DurationGroup, scales = "free_y")


# ggsave(filename = "Defunct airlines of Australia.png",
#        plot = p,
#        width = 16,
#        height = 12,
#        dpi = 300,
#        bg = "white",
#        units = "in")
