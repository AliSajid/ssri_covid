library(tidyverse)
library(httr)
library(jsonlite)
source("pipeline.R")

drugs_signatures <- unlist(strsplit(read_file("drugs_signature_ids"), split = "\n"))
targets_signatures <- unlist(strsplit(read_file("targets_signature_ids"), split = "\n"))

for (drug in drugs_signatures) {
  prefix <- paste("data", "signatures", sep = "/")
  filename <- paste(paste(drug, "Signature", sep = "-"), "tsv", sep = ".")
  fullname <- paste(prefix, filename, sep = "/")
  if (!file.exists(fullname)) {
    sig <- get_l1000_signature(drug)
    write_tsv(sig, path = fullname)
  }
}

for (target in targets_signatures) {
  prefix <- paste("data", "signatures", sep = "/")
  filename <- paste(paste(target, "Signature", sep = "-"), "tsv", sep = ".")
  fullname <- paste(prefix, filename, sep = "/")
  if (!file.exists(fullname)) {
    sig <- get_l1000_signature(target)
    write_tsv(sig, path = fullname)
  }}

for (drug in drugs_signatures) {
  prefix <- paste("data", "signatures", sep = "/")
  filename <- paste(paste(drug, "Signature", sep = "-"), "tsv", sep = ".")
  fullname <- paste(prefix, filename, sep = "/")
  up <- generate_filtered_signature(signature_file = fullname, direction = "up")
  down <- generate_filtered_signature(signature_file = fullname, direction = "down")
  consensus <- bind_rows(up, down)
  
  consensus_prefix <- paste("data", "filtered", sep = "/")
  consensus_filename <- paste(paste(drug, "Consensus", "Signature", sep = "-"), "tsv", sep = ".")
  consensus_fullname <- paste(consensus_prefix, consensus_filename, sep = "/")

  write_tsv(consensus, consensus_fullname)
  
}

for (target in targets_signatures) {
  prefix <- paste("data", "signatures", sep = "/")
  filename <- paste(paste(target, "Signature", sep = "-"), "tsv", sep = ".")
  fullname <- paste(prefix, filename, sep = "/")
  up <- generate_filtered_signature(signature_file = fullname, direction = "up")
  down <- generate_filtered_signature(signature_file = fullname, direction = "down")
  consensus <- bind_rows(up, down)
  
  consensus_prefix <- paste("data", "filtered", sep = "/")
  consensus_filename <- paste(paste(target, "Consensus", "Signature", sep = "-"), "tsv", sep = ".")
  consensus_fullname <- paste(consensus_prefix, consensus_filename, sep = "/")
  
  write_tsv(consensus, consensus_fullname)
}

