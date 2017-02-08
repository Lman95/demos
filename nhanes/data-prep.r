library(SASxport)
library(dplyr)

physical <- read.xport("data/raw/PAQ_H.xpt")
demo <- read.xport("data/raw/DEMO_H.xpt")

merged <- left_join(physical, demo, by="SEQN")

