library(dplyr)
library(ggplot2)
prison_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")
jail_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-jail-pop.csv")
rates_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates.csv")
rates_1990_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990.csv")
rates_1990_wa_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990-WA.csv")


# Filter out rows with missing data
prison_data <- prison_data %>%
  filter(!is.na(total_prison_pop))

jail_data <- jail_data %>%
  filter(!is.na(total_jail_pop))

# Group the data by year and calculate the total prison and jail populations for each year
combined_data <- inner_join(prison_data, jail_data, by = c("year", "state")) %>%
  select(year, total_prison_pop, total_jail_pop)

# Plot the comparison chart
ggplot(combined_data, aes(x = year)) +
  geom_line(aes(y = total_prison_pop, color = "Total Prison Population")) +
  geom_line(aes(y = total_jail_pop, color = "Total Jail Population")) +
  labs(title = "Comparison of Total Prison and Jail Populations Over Time",
       x = "Year",
       y = "Population",
       color = "Population Type") +
  scale_color_manual(values = c("Total Prison Population" = "blue", "Total Jail Population" = "red")) +
  theme_minimal() +
  theme(legend.title = element_blank())
