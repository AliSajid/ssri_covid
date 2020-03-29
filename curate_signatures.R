library(tidyverse)

common_cell_lines <- c("A375", "MCF7")

fluoxetine <- read_tsv("signature_data/Fluoxetine-Signatures.tsv") %>% 
  filter(is_exemplar == 1, CellLine %in% common_cell_lines)
escitalopram <- read_tsv("signature_data/Escitalopram-Signatures.tsv") %>% 
  filter(Perturbagen == "Escitalopram", is_exemplar == 1, CellLine %in% common_cell_lines)
sertraline <- read_tsv("signature_data/Sertraline-Signatures.tsv") %>% 
  filter(is_exemplar == 1, Perturbagen == "Sertraline", CellLine %in% common_cell_lines)

IL6 <- read_tsv("signature_data/IL6-Signatures.tsv") %>% 
  filter(TargetGene == "IL6", is_exemplar == 1, CellLine %in% common_cell_lines)

IL6R <- read_tsv("signature_data/IL6-Signatures.tsv") %>% 
  filter(TargetGene == "IL6R", is_exemplar == 1, CellLine %in% common_cell_lines)

IL6ST <- read_tsv("signature_data/IL6-Signatures.tsv") %>% 
  filter(TargetGene == "IL6ST", is_exemplar == 1, CellLine %in% common_cell_lines)

drugs <- bind_rows(fluoxetine, escitalopram, sertraline)
write_file(paste(drugs$SignatureId, collapse = "\n"), "drugs_signature_ids")
targets <- bind_rows(IL6, IL6R, IL6ST)
write_file(paste(targets$SignatureId, collapse = "\n"), "targets_signature_ids")