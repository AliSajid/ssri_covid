library(tidyverse)
library(gplots)

genes <- c("IL6", "IL6R", "IL6ST", "NFKB1", "NFKB2", "TNF", "RELA", "RELB", "REL", "CREL")

data <- list()

for (g in genes) {
  file_name <- paste(paste(g, "cross", "unlimited", sep = "-"), "csv", sep = ".")
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
  file_name <- paste(paste(g, "unlimited", "heatmap", sep = "-"), "png", sep = ".")
  full_name <- paste("figures", file_name, sep = "/")
  if (g %in% names(data)) {
    d <- data[[g]]
    heatmap.2(d, dendrogram = "none", col = colors, colsep = 1:(dim(d)[2] - 1), rowsep = 1:(dim(d)[1] - 1),
              trace = "none", cexRow = 3, cexCol = 3, Rowv = FALSE, Colv = FALSE,
              density.info = "none", keysize = 1, margins = c(15, 25), notecex=2.0,
              main = paste("Concordance across cell lines for", g),
              key.title = NA, key.xlab = NA, key.par = list(cex = 1.3), cellnote = d, notecol = "white")
    png(filename = full_name, width = 1920, height = 1384)
    heatmap.2(d, dendrogram = "none", col = colors, colsep = 1:(dim(d)[2] - 1), rowsep = 1:(dim(d)[1] - 1),
              trace = "none", cexRow = 3, cexCol = 3, Rowv = FALSE, Colv = FALSE,
              density.info = "none", keysize = 1, margins = c(15, 25), notecex=2.0,
              main = paste("Concordance across cell lines for", g),
              key.title = NA, key.xlab = NA, key.par = list(cex = 1.3), cellnote = d, notecol = "white")
    dev.off()
  }
}
