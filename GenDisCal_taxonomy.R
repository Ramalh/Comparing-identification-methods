organism <- read.csv("../Organisms for evaluation.csv", header = T)
organism <- organism[!apply(organism=="", 1, all),]

taxid_list <- data.frame(organism$ï..assembly_accession, organism$species_taxid)

write.csv(taxid_list, "../NCBI_taxonomy_species.csv", row.names = F, quote = F)
