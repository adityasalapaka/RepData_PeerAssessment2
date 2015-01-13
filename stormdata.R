download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", 
              "stormdata.csv.bz2")

data <- read.csv(bzfile("stormdata.csv.bz2")) # cache = TRUE

# Subset relevant data

subsetData <- subset(data, select = c("BGN_DATE","EVTYPE","PROPDMG",
                                            "PROPDMGEXP","CROPDMG","CROPDMGEXP",
                                            "FATALITIES","INJURIES"))

# Clean up date
BGN_DATE <- subsetData$BGN_DATE
BGN_DATE <- substr(BGN_DATE, 1, 9)
data$BGN_DATE <- as.Date(BGN_DATE, format = "%m/%d/%Y")

# No. of unique events each year. Group by year and find unique events in
# each year.

# Across the United States, which types of events (as indicated in the EVTYPE 
# variable) are most harmful with respect to population health?

# Across the United States, which types of events have the greatest economic 
# consequences?

# group by type and take sum of deaths and injuries in one column



