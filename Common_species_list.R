library(readr)
library(ape)

names <- read_delim("../names.dmp", "|\t", escape_double = FALSE, 
                    trim_ws = TRUE, col_names = c("taxid", "txt", "X3", "X4", "X5"),
                    col_types = cols_only("taxid" = "c", "txt" = "c"))

names$txt <- gsub(" ", "_", names$txt)

asmbl <- read_delim("../assembly_summary_refseq.txt", "\t", escape_double = FALSE, col_names = T 
                    , col_types = cols_only("assembly_accession" = "c",	"refseq_category" = "c",	
                                            "taxid" = "c",	"species_taxid" = "c",	"organism_name" = "c",	"gbrs_paired_asm" = "c",
                                            "ftp_path" = "c"), trim_ws = TRUE)
category <- read_delim("../categories.dmp", "\t", escape_double = F, trim_ws = T, col_names = F, col_types = cols_only(
  "X1" = "c", "X2" = "c", "X3" = "c"
))
asmbl <- asmbl[asmbl$taxid %in% category$X2, ]

#Assigning all species names to a file which will be uploaded to Timetree.org to query
tree_names <- unique(asmbl$organism_name)
write_csv(tree_names, file = "../tree_names.txt", row.names = F, quote = F)

#the file which downloaded from Timetree.org after commiting the query
tree <- read.tree("../tree_names.nwk")

taxid <- unique(c(asmbl$species_taxid, asmbl$taxid))

names_in_ours <- names$taxid %in% asmbl$species_taxid
names_in_tree <- names$txt %in% tree$tip.label
keep <- subset(names, names_in_ours & names_in_tree)

t_name <- keep$txt
names(t_name) <- keep$taxid

asmbl <- subset(asmbl, taxid %in% keep$taxid | species_taxid %in% keep$taxid)
asmbl$sname <- t_name[asmbl$species_taxid]

tree_in_ours <- tree$tip.label %in% asmbl$sname
tt <- drop.tip(tree, tree$tip.label[!tree_in_ours])

dist <- cophenetic.phylo(tt)

asmbl<-asmbl[match(unique(asmbl$species_taxid), asmbl$species_taxid),]

write.table(asmbl, file = "../All_asmbl.txt",  sep = "\t", row.names = F, quote = F)

#Changing matrix col and row names to GCF numbers

colnames(dist) <- asmbl$assembly_accession[match(colnames(dist), asmbl$sname)]
rownames(dist) <- asmbl$assembly_accession[match(rownames(dist), asmbl$sname)]

save(dist, file = "../timetree-dist.Rdata")
