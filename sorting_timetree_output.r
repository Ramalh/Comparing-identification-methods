#Converting matrix to phylogenetic distance list

load("../timetree-dist.Rdata")

t = rep(NA,length(colnames(dist))*(length(colnames(dist))-1)/2)
k <- 1
for (i in 1:(length(colnames(dist))-1)){
  for (j in (i+1):length(colnames(dist))){
    t[k] <- paste(colnames(dist)[i],rownames(dist)[j],dist[i,j], sep = ",")
    k <- k+1
  }
}

write(t, file = "../read_tree/tree_distances.txt")

#Sorting Phylogenetic list files

tree_distance <- read.csv("../read_tree/tree_distances.txt", header = F)
len <- length(tree_distance$V1)
name_tree <- rep(NA, (len-1))

for (i in 1:len){
  p <- sort(c(as.character(tree_distance$V1[[i]]), as.character(tree_distance$V2[[i]])))
  name_tree[i] <- paste(p[1], p[2], sep = "_")
}
tree_distance$name_tree <- name_tree
tree_distance$V2 <-  tree_distance$V2[match(sort(tree_distance$name_tree), tree_distance$name_tree)]
tree_distance$V1 <-  tree_distance$V1[match(sort(tree_distance$name_tree), tree_distance$name_tree)]
tree_distance$V3 <-  tree_distance$V3[match(sort(tree_distance$name_tree), tree_distance$name_tree)]
tree_distance$name_tree <- sort(tree_distance$name_tree)

write.csv(tree_distance, file = "../read_tree/sorted_tree.txt", row.names = F, quote = F)