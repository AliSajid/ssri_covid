library(tidyverse)

#files <- list.files("results/drugs", full.names = T)
drugs_signatures <- unlist(strsplit(read_file("drugs_signature_ids"), split = "\n"))

prefix <- paste("results", "drugs", sep = "/")
filenames <- paste(paste(drugs_signatures, "Concordant", sep = "-"), "tsv", sep = ".")

files <- paste(prefix, filenames, sep = "/")

metadata <- read_csv("signature_data/id-name-cellline_mapping.csv")

col_spec <- cols(
  similarity = col_double(),
  pValue = col_double(),
  nGenes = col_double(),
  treatment = col_character(),
  perturbagenID = col_character(),
  time = col_character(),
  signatureid = col_character(),
  cellline = col_character(),
  Source_Signature = col_character()
)

dfs <- list()

for (i in 1:length(files)) {
  df <- read_tsv(files[i], col_types = col_spec)
  dfs[[i]] <- df
}

df <- reduce(dfs, bind_rows)

complete <- inner_join(df, metadata, by = c("Source_Signature" = "SignatureId", "cellline" = "CellLine"))

filter_data <- function(data, cell_line, cutoff) {
    dataframe <- data
    output <- dataframe %>%
    filter(cellline == cell_line) %>%
    group_by(cellline, treatment, Perturbagen) %>%
    filter(similarity == max(similarity)) %>%
    ungroup() %>% 
    select(signatureid, treatment, Perturbagen, similarity, pValue, cellline)
    return(output)
  }

analysed <- complete %>% 
  group_by(cellline, treatment, Perturbagen) %>% 
  filter(similarity == max(similarity))

cell_lines <- c("A375", "A549", "HA1E", "HCC515", "HEPG2", "HT29", "MCF7", "PC3")

for (cell in cell_lines) {
  outfile <- paste("results", paste(paste(cell, "result", sep = "-"), "csv", sep = "."), sep = "/")
  
  analysed %>% 
    filter(cellline == cell) %>% 
    write_csv(outfile)
}
