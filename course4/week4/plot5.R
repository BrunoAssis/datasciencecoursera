NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

baltimore.code <- "24510"
baltimore.emissions <- subset(NEI, fips == baltimore.code)

motor.related.sccs <- subset(SCC, grepl(x = Short.Name,
                                        pattern = "\\bVehicle",
                                        ignore.case = TRUE))

baltimore.motor.related.emissions <- subset(baltimore.emissions,
                                            SCC %in% motor.related.sccs$SCC)
baltimore.motor.related.emissions.by.year <- aggregate(Emissions ~ year,
                                                       baltimore.motor.related.emissions,
                                                       sum)

png(filename="plot5.png")

barplot(baltimore.motor.related.emissions.by.year$Emissions,
        names.arg = baltimore.motor.related.emissions.by.year$year,
        xlab = "Year",
        ylab = "PM 2.5 Emissions (in Tons)",
        main = "Total PM 2.5 Motor Vehicle Related Emissions in Baltimore City")

dev.off()