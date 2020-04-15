library(tidyverse)

fluoxetine <- read_tsv("signature_data/Fluoxetine-Signatures.tsv")

bupropion <- read_tsv("signature_data/Bupropion-Signatures.tsv")

paroxetine <- read_tsv("signature_data/Paroxetine-Signatures.tsv")

dexa <- read_tsv("signature_data/Dexamethasone-Signatures.tsv")

hydroxychloroquine <- read_tsv("signature_data/Hydroxychloroquine-Signatures.tsv")

chloroquine <- read_tsv("signature_data/Chloroquine-Signatures.tsv")

drugs_list <- list(fluoxetine, bupropion, paroxetine, dexa, chloroquine)

selected_lines <- list()

for (i in 1:length(drugs_list)) {
  selected_lines[[i]] <- drugs_list[[i]]$CellLine
}

cell_lines <- reduce(selected_lines, intersect)

drugs <- bind_rows(fluoxetine, bupropion, paroxetine, dexa, hydroxychloroquine, chloroquine) %>% 
  filter(CellLine %in% cell_lines)

write_file(paste(drugs$SignatureId, collapse = "\n"), "drugs_signature_ids")

drugs %>% select(SignatureId, Perturbagen, CellLine) %>% 
  write_csv("signature_data/id-name-cellline_mapping.csv")
