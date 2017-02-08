```{r, echo=FALSE, message=FALSE, warning=FALSE} 
library(dplyr)
library(tidyr)

data <- read.csv("data/prepped/risk-factors.csv")

data <- mutate(data, average.risk = rowMeans(dplyr::select(data, starts_with("X")), na.rm = TRUE))
```



               