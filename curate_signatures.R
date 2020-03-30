library(tidyverse)

fluoxetine <- read_tsv("signature_data/Fluoxetine-Signatures.tsv")

bupropion <- read_tsv("signature_data/Bupropion-Signatures.tsv")

paroxetine <- read_tsv("signature_data/Paroxetine-Signatures.tsv")


IL6 <- read_tsv("signature_data/IL6-Signatures.tsv") %>% 
  filter(TargetGene == "IL6")

IL6R <- read_tsv("signature_data/IL6-Signatures.tsv") %>% 
  filter(TargetGene == "IL6R")

IL6ST <- read_tsv("signature_data/IL6-Signatures.tsv") %>% 
  filter(TargetGene == "IL6ST")

drugs <- bind_rows(fluoxetine, bupropion, paroxetine)
write_file(paste(drugs$SignatureId, collapse = "\n"), "drugs_signature_ids")
targets <- bind_rows(IL6, IL6R, IL6ST)
write_file(paste(targets$SignatureId, collapse = "\n"), "targets_signature_ids")