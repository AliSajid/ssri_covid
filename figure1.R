library(tidyverse)

df <- read_csv("results/IL6ST.csv")

p <-  ggplot(df, 
             aes(x = perturbagen, 
                 y = similarity, 
                 group = cellline, 
                 color = cellline,
                 label = similarity)
             )

p + geom_point() + geom_line() + 
  scale_x_discrete(limits = c("Bupropion", "Paroxetine",  "Dexamethasone", "Fluoxetine")) +
  xlab("Medication") +
  ylab("Similarity Score reelative to IL6ST Knockout") +
  scale_color_discrete(name = "Cell Line") + 
  geom_text(aes(label=similarity), hjust = -0.5, vjust = 0)
