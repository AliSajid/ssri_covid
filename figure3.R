library(tidyverse)

genes <- c("IL6", "IL6R", "IL6ST", "NFKB1", "NFKB2", "TNF", "RELA", "RELB", "REL", "CREL")

data <- list()

for (g in genes) {
  file_name <- paste(paste(g, "cross", "unlimited", sep = "-"), "csv", sep = ".")
  full_name <- paste("results", file_name, sep = "/")
  d <- read_csv(full_name) %>% 
    select(-X1) %>% 
    column_to_rownames("cellline") %>% 
    as.matrix()
  data[[g]] <- t(d)
}

colors <- colorRampPalette(c("red", "black", "green"))(11)

for (g in genes) {
  file_name <- paste(paste(g, "unlimited", "heatmap", sep = "-"), "png", sep = ".")
  full_name <- paste("figures", file_name, sep = "/")
  d <- data[[g]]
  heatmap(d, Colv = NA, Rowv = NA, scale = "column", col = colors, main = g)
  png(filename = full_name, width = 1920, height = 1384)
  heatmap(d, Colv = NA, Rowv = NA, scale = "column", col = colors, main = g)
  dev.off()
}
