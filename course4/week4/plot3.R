NEI <- readRDS("data/summarySCC_PM25.rds")

library(ggplot2)

baltimore.code <- "24510"
baltimore.emissions <- subset(NEI, fips == baltimore.code)
baltimore.emissions$year <- factor(baltimore.emissions$year)

png(filename="plot3.png")

ggplot(baltimore.emissions, aes(x = year, y = Emissions)) +
  facet_grid(. ~ type) +
  geom_bar(stat="identity") +
  labs(x = "Years",
       y = "PM 2.5 Emissions (in Tons)",
       title = "Total PM 2.5 Emissions in Baltimore City by Type")

dev.off()