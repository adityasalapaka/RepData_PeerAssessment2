download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", 
              "stormdata.csv.bz2")
data <- read.csv(bzfile("stormdata.csv.bz2")) # cache = TRUE

# Across the United States, which types of events (as indicated in the EVTYPE 
# variable) are most harmful with respect to population health?

# Across the United States, which types of events have the greatest economic 
# consequences?

# group by type and take sum of deaths and injuries in one column