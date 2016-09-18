NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

baltimore.code <- "24510"
baltimore.emissions <- subset(NEI, fips == baltimore.code)
baltimore.emissions.by.year <- aggregate(Emissions ~ year,
                                         baltimore.emissions,
                                         sum)

png(filename="plot2.png")

barplot(baltimore.emissions.by.year$Emissions,
        names.arg = baltimore.emissions.by.year$year,
        xlab = "Year",
        ylab = "PM 2.5 Emissions (in Tons)",
        main = "Total PM 2.5 Emissions in Baltimore City")

dev.off()