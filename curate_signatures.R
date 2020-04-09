library(tidyverse)

cell_lines <- c("A375", "A549", "HA1E", "HCC515", "HEPG2", "HT29", "MCF7", "PC3")

fluoxetine <- read_tsv("signature_data/Fluoxetine-Signatures.tsv") %>% 
  filter(CellLine %in% cell_lines)

bupropion <- read_tsv("signature_data/Bupropion-Signatures.tsv") %>% 
  filter(CellLine %in% cell_lines)

paroxetine <- read_tsv("signature_data/Paroxetine-Signatures.tsv") %>% 
  filter(CellLine %in% cell_lines)

dexa <- read_tsv("signature_data/Dexamethasone-Signatures.tsv") %>% 
  filter(CellLine %in% cell_lines)

hydroxychloroquine <- read_tsv("signature_data/Hydroxychloroquine-Signatures.tsv") %>% 
  filter(CellLine %in% cell_lines)

chloroquine <- read_tsv("signature_data/Chloroquine-Signatures.tsv") %>% 
  filter(CellLine %in% cell_lines)

IL6 <- read_tsv("signature_data/IL6-Signatures.tsv") %>% 
  filter(TargetGene == "IL6", CellLine %in% cell_lines)

IL6R <- read_tsv("signature_data/IL6-Signatures.tsv") %>% 
  filter(TargetGene == "IL6R", CellLine %in% cell_lines)

IL6ST <- read_tsv("signature_data/IL6-Signatures.tsv") %>% 
  filter(TargetGene == "IL6ST", CellLine %in% cell_lines)

drugs <- bind_rows(fluoxetine, bupropion, paroxetine, dexa, hydroxychloroquine, chloroquine)
write_file(paste(drugs$SignatureId, collapse = "\n"), "drugs_signature_ids")
targets <- bind_rows(IL6, IL6R, IL6ST)
write_file(paste(targets$SignatureId, collapse = "\n"), "targets_signature_ids")
drugs %>% select(SignatureId, Perturbagen, CellLine) %>% 
  write_csv("signature_data/id-name-cellline_mapping.csv")
