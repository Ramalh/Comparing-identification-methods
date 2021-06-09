genetic_distance <- read.csv("../GenDisCal_outputs/sorted_euk_karl4.csv", header = T)
tree_distance <- read.csv("../read_tree/sorted_euk_tree.csv", header = T)

genetic_distance$tree <- tree_distance$V3

for (i in 1:7){
  log <- genetic_distance$Expected_Relation %in% names(1/table(genetic_distance$Expected_Relation)[i]*100)
  genetic_distance$weight[log] <- 1/table(genetic_distance$Expected_Relation)[i]*100
}
Model <- lm(log10(genetic_distance$tree[genetic_distance$tree > 100]) ~ genetic_distance$Distance[genetic_distance$tree > 100]
            ,weights = as.numeric(genetic_distance$weight[genetic_distance$tree > 100])
            )
summary(Model)$r.squared
