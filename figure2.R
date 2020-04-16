library(tidyverse)

genes <- c("IL6", "IL6R", "IL6ST", "NFKB1", "NFKB2", "TNF", "RELA", "RELB", "REL", "CREL")

data <- list()

for (g in genes) {
  file_name <- paste(paste(g, "cross", sep = "-"), "csv", sep = ".")
  full_name <- paste("results", file_name, sep = "/")
  if (file.exists(full_name)) {
    d <- read_csv(full_name) %>% 
      select(-X1) %>% 
      column_to_rownames("cellline") %>% 
      as.matrix()
    data[[g]] <- t(d)
  }
}

colors <- colorRampPalette(c("red", "black", "green"))(11)

for (g in genes) {
  file_name <- paste(paste(g, "heatmap", sep = "-"), "png", sep = ".")
  full_name <- paste("figures", file_name, sep = "/")
  if (g %in% names(data)) {
    d <- data[[g]]
    heatmap(d, Colv = NA, Rowv = NA, scale = "column", col = colors, main = g)
    png(filename = full_name, width = 1920, height = 1384)
    heatmap(d, Colv = NA, Rowv = NA, scale = "column", col = colors, main = g)
    dev.off()
  }
}
