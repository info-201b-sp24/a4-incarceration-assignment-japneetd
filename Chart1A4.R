library(dplyr)
library(ggplot2)
prison_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")
jail_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-jail-pop.csv")
rates_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates.csv")
rates_1990_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990.csv")
rates_1990_wa_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990-WA.csv")


prison_data <- prison_data %>%
  filter(!is.na(total_prison_pop))
state_totals <- prison_data %>%
  group_by(state, year) %>%
  summarise(total_prison_pop = sum(total_prison_pop))
top_states <- state_totals %>%
  group_by(state) %>%
  summarise(total_prison_pop = sum(total_prison_pop)) %>%
  top_n(5, total_prison_pop) %>%
  pull(state)
top_state_data <- state_totals %>%
  filter(state %in% top_states)
ggplot(top_state_data, aes(x = year, y = total_prison_pop, color = state)) +
  geom_line() +
  labs(title = "Trend of Total Prison Population Over Time (Top 5 States)",
       x = "Year",
       y = "Total Prison Population",
       color = "State") +
  theme_minimal() +
  theme(legend.position = "bottom")
