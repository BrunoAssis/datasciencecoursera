NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

coal.related.sccs <- subset(SCC, grepl(x = Short.Name,
                                       pattern = "\\bcoal",
                                       ignore.case = TRUE))
coal.combustion.related.sccs <- subset(coal.related.sccs,
                                       grepl(x = Short.Name,
                                             pattern = "\\bcomb",
                                             ignore.case = TRUE))
coal.combustion.related.emissions <- subset(NEI, SCC %in% coal.combustion.related.sccs$SCC)
coal.combustion.related.emissions.by.year <- aggregate(Emissions ~ year,
                                                       coal.combustion.related.emissions,
                                                       sum)

png(filename="plot4.png")

barplot(coal.combustion.related.emissions.by.year$Emissions,
        names.arg = coal.combustion.related.emissions.by.year$year,
        xlab = "Year",
        ylab = "PM 2.5 Emissions (in Tons)",
        main = "Total PM 2.5 Coal Combustion Related Emissions in the US")

dev.off()