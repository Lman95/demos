# Analysis

# Set up
setwd('~/Documents/info-498c/demos/gbd/disability-weights/')
library(dplyr)
library(tidyr)

# Load global data (disease burden in 2015, both sexes, all ages)
global.data <- read.csv('./data/prepped/global_burden.csv', stringsAsFactors = FALSE)

# Replace NA as 0 for deaths, ylls, ylds
# Thanks, SO: http://stackoverflow.com/questions/8161836/how-do-i-replace-na-values-with-zeros-in-an-r-dataframe
global.data[is.na(global.data)] <- 0

# What disease was responsible for the most burden (by each metric)?
max.death <- filter(global.data, deaths == max(global.data$deaths))

max.dalys <- filter(global.data, dalys == max(global.data$dalys))

max.ylls <- filter(global.data, ylls == max(global.data$ylls))

max.ylds <- filter(global.data, ylds == max(global.data$ylds))

# Using prevalence and YLDs, calculate inferred disability weights (not actual weights in the study)
global.data <- mutate(global.data, d.weights = ylds / prevalence)

# See anything strange about the estimated disability weights?


# Which diseases have more YLDs than YLLs (and ylls > 0)?
yld.more.than.yll <- filter(global.data, ylds > ylls & ylls > 0)

# How many times higher is the prevalence than the number of deaths for these diseases?
yld.more.than.yll <- mutate(yld.more.than.yll, times.higher = prevalence / deaths)

# Which disease has the most similar burden of YLLs and YLDs (where ylls > 0)?
closest.yll.yld <- mutate(yld.more.than.yll, difference = ylds - ylls) %>% 
                   filter(difference == min(difference))

# For the following section, keep only the cause names and disability weights
cause.and.weight <- select(yld.more.than.yll, cause, d.weights)

# For each cause, compute how many cases would have to have to be avoided to equal 65 YLLs
# (the equivalent of one death of a 25 year old)


