#Day 3: makeover
# original chart URL: https://www.forbes.com/sites/naomirobbins/2012/02/16/misleading-graphs-figures-not-drawn-to-scale/?sh=450af71b15ef

library(waffle)
library(hrbrthemes)
library(tidyverse)



medals <- tibble(parts = c("U.S.A.", "Russia", "Britain", "France", "Germany"),
                    vals = c(1975, 999, 615, 523, 499))

medals$parts <- factor(medals$parts, levels = c("U.S.A.", "Russia", "Britain", "France", "Germany"))

str(medals)



ggplot(
  data = medals, 
  aes(fill=parts, values=vals/10)
) +
  geom_waffle(
    color = "white", 
    size = 0.5, 
    n_rows = 5
  ) +
  facet_wrap(~parts, ncol=1) +
  geom_text(
    aes(label=format(prettyNum(medals$vals, big.mark = ",")), x=c(42, 22, 15, 13, 12), y=1),
    size = 3, # Adjust text size as needed
    color = "black")+
  scale_x_discrete(
    expand = c(0,0,0,5)
  ) +
  scale_y_discrete(
    expand = c(0,0,0,0)
  ) +
  ggthemes::scale_fill_tableau(name=NULL) +
  coord_equal() +
  labs(
    title = "Summer Olympic Medal Count (up to Aug 2004)"
  ) +
  theme_ipsum_rc(grid="") +
  theme_enhance_waffle() +
  theme(panel.spacing = unit(0.3, "cm"),
        legend.position = 'none'
        # legend.position = c(0.85, 0.1),
        # legend.margin = margin(0, 0, 0, 0),
        # legend.key.size = unit(0.5, "cm"),
        # legend.text = element_text(size = 8)
        )

