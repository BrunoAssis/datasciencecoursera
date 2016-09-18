NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

library(ggplot2)

motor.related.sccs <- subset(SCC, grepl(x = Short.Name,
                                        pattern = "\\bVehicle",
                                        ignore.case = TRUE))

baltimore.code <- "24510"
los.angeles.code <- "06037"

baltimore.records <- subset(NEI, fips == baltimore.code)
baltimore.records$city <- "Baltimore"

los.angeles.records <- subset(NEI, fips == los.angeles.code)
los.angeles.records$city <- "Los Angeles"

baltimore.and.los.angeles.emissions <- rbind(baltimore.records, los.angeles.records)

baltimore.and.los.angeles.motor.related.emissions <- subset(baltimore.and.los.angeles.emissions,
                                                            SCC %in% motor.related.sccs$SCC)
baltimore.and.los.angeles.motor.related.emissions$year <- factor(baltimore.and.los.angeles.motor.related.emissions$year)

png(filename="plot6.png")

ggplot(baltimore.and.los.angeles.motor.related.emissions, aes(x = year, y = Emissions)) +
  facet_grid(. ~ city) +
  geom_bar(stat="identity") +
  labs(x = "Years",
       y = "PM 2.5 Emissions (in Tons)",
       title = "Total PM 2.5 Emissions in Baltimore and Los Angeles")

dev.off()