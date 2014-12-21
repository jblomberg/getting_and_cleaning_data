# Using this script

The script expects to be adjacent to the Samsung data. Specifically, it expects the `UCI HAR Dataset` folder to be in your working directory.

```
source("run_analysis.R")
tidyData <- run_analysis()
```

# Feature Selection

Columns were included that contained in "mean()" or "std()". This purposefully excluded columns such as "fBodyAcc-meanFreq()-X" or "angle(X,gravityMean)"

