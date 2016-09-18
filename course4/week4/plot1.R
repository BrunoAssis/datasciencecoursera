NEI <- readRDS("data/summarySCC_PM25.rds")

emissions.by.year <- aggregate(Emissions ~ year, NEI, sum)

png(filename="plot1.png")

barplot(emissions.by.year$Emissions,
        names.arg = emissions.by.year$year,
        xlab = "Year",
        ylab = "PM 2.5 Emissions (in Tons)",
        main = "Total PM 2.5 Emissions in the US")

dev.off()
