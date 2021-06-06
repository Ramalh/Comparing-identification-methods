library(readr)

root <- read_delim("C:/Users/Ramal/Documents/categories.dmp", "\t", col_names = F, col_types = cols(X3 =col_skip()))

root <- root[match(unique(root$X2), root$X2),]

asmbl <- read_delim("../All_asmbl.txt", "\t", escape_double = FALSE, col_names = T 
                    , col_types = cols_only("assembly_accession" = "c",	"refseq_category" = "c",	
                                            "taxid" = "c",	"species_taxid" = "c",	"organism_name" = "c",	"gbrs_paired_asm" = "c",
                                            "ftp_path" = "c", "sname" = "c"), trim_ws = TRUE)


asmbl <- read.delim("trimed_asmbl.txt", header = T)
all_species <- root$X2 %in% asmbl$species_taxid
species <- root[all_species,]

asmbl_bac <- asmbl[asmbl$species_taxid %in% root$X2[root$X1 == "B"],]
asmbl_euk <- asmbl[asmbl$species_taxid %in% root$X2[root$X1 == "E"],]

write.table(asmbl_bac, file = "Bacteria_asmbl.txt", sep = "\t", row.names = F, quote = F)
write.table(asmbl_euk, file = "Eukaryote_asmbl.txt", sep = "\t", row.names = F, quote = F)
