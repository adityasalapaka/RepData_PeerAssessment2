download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", 
              "stormdata.csv.bz2")

# data <- read.csv(bzfile("stormdata.csv.bz2")) # cache = TRUE
# subsetData <- read.csv("subsetdata.csv")

# Subset relevant data

subsetData <- subset(data, select = c("BGN_DATE","EVTYPE","PROPDMG",
                                            "PROPDMGEXP","CROPDMG","CROPDMGEXP",
                                            "FATALITIES","INJURIES"))
rm(data)

# Clean up date
BGN_DATE <- subsetData$BGN_DATE
BGN_DATE <- substr(BGN_DATE, 1, 9)
subsetData$BGN_DATE <- as.Date(BGN_DATE, format = "%m/%d/%Y")

# No. of unique events each year. Group by year and find unique events in
# each year.

# Across the United States, which types of events (as indicated in the EVTYPE 
# variable) are most harmful with respect to population health?

# Across the United States, which types of events have the greatest economic 
# consequences?

# group by type and take sum of deaths and injuries in one column

exponent <- function (x){
        x <- as.character(x)
        ifelse(x == "B", as.numeric(1000000000), 
               ifelse(x == "M", as.numeric(1000000), 
                      ifelse(x == "K", as.numeric(1000), 0)))
}

subsetData$PROPDMGEXP <- toupper(subsetData$PROPDMGEXP)
subsetData$PROPDMGEXP <- exponent(subsetData$PROPDMGEXP)
subsetData$PROPDMGEXPTOT <- as.numeric(subsetData$PROPDMG*subsetData$PROPDMGEXP)

subsetData$CROPDMGEXP <- toupper(subsetData$CROPDMGEXP)
subsetData$CROPDMGEXP <- exponent(subsetData$CROPDMGEXP)
subsetData$CROPDMGEXPTOT <- as.numeric(subsetData$CROPDMG*subsetData$CROPDMGEXP)


#all 48 events present from 1996. drop all previous data as incomplete.
subsetData <- subset(subsetData, subsetData$BGN_DATE > as.Date("1995-12-31"))

subsetData$EVTYPE <- toupper(subsetData$EVTYPE)

length(unique(subsetData$EVTYPE)) #407 types wtf

x <- readLines("events.txt")
x <- toupper(x)

similarevents <- function(x){
        unique(grep("ASTRONOMICAL LOW TIDE|AVALANCHE|BLIZZARD|COASTAL FLOOD|
        COLD/WINDHILL|DEBRIS FLOW|DENSE FOG|DENSE SMOKE|DROUGHT|DUST DEVIL|
        DUST STORM|EXCESSIVE HEAT|EXTREMEOLD/WINDHILL|FLASH FLOOD|FLOOD|
        FROST/FREEZE|FUNNELLOUD|FREEZING FOG|HAIL|HEAT|HEAVY RAIN|HEAVY SNOW|
        HIGH SURF|HIGH WIND|HURRICANE (TYPHOON)|ICE STORM|LAKE-EFFECT SNOW|
        LAKESHORE FLOOD|LIGHTNING|MARINE HAIL|MARINE HIGH WIND|
        MARINE STRONG WIND|MARINE THUNDERSTORM WIND|RIPURRENT|SEICHE|SLEET|
        STORM SURGE/TIDE|STRONG WIND|THUNDERSTORM WIND|TORNADO|
        TROPICAL DEPRESSION|TROPICAL STORM|TSUNAMI|VOLCANIC ASH|WATERSPOUT|
        WILDFIRE|WINTER STORM|WINTER WEATHER", subsetData$EVTYPE, 
                    value = TRUE, invert = x))
}

difference <- sort(str_trim(setdiff(similarevents(FALSE), x)))

replace(x)

for (i in 1:length(x)){
        subsetData$EVTYPE[grepl(x[i], subsetData$EVTYPE)] <- x[i]
}

for (i in 1:length(x)){
        print(unique(grep(x[i], subsetData$EVTYPE, value = TRUE)))
}

findevent <- function(x){
        unique(grep(x, subsetData$EVTYPE, value = TRUE))
}
