library(dplyr)
library(ggplot2)
library(maps)
prison_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")
jail_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-jail-pop.csv")
rates_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates.csv")
rates_1990_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990.csv")
rates_1990_wa_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990-WA.csv")

women_in_prison <- data.frame(
  state = c("Washington", "Texas", "Arizona", "New York", "California"),
  women_in_prison_rate = c(10, 20, 15, 12, 18) # Sample rates for illustration
)
us_map <- map_data("usa")

map_data <- merge(us_map, women_in_prison, by.x = "region", by.y = "state", all.x = TRUE)


ggplot(map_data, aes(x = long, y = lat, group = group, fill = women_in_prison_rate)) +
  geom_polygon(color = "black") +
  scale_fill_gradient(name = "Women in Prison Rate", low = "lightblue", high = "darkblue") +
  labs(title = "Women in Prison Rate Across U.S. States") +
  theme_void()
