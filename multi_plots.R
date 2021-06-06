list1 <- read.delim("C:/Users/Ramal/Documents/GenDisCal_outputs/outputs/list.txt", sep = "\n", stringsAsFactors = F)
list1 <- sort(list1$file)

#copy the paths of files need to be sorted and trimed
paths <- readClipboard()
paths <- gsub('\"', '', paths)
tree_distance <- read.csv("../read_tree/sorted_tree.csv", header = T)

m <- matrix(c(1,2,3,4,5,6,7,7,7),nrow = 3,ncol = 3,byrow = TRUE)
layout(mat = m,heights = c(0.4,0.4,0.15))
par(mar = c(4,5,2,1))

for (i in 1:length(paths)){
  genetic_distance <- read.csv(paths[i], header = T)
  plot((genetic_distance$Distance), (tree_distance$V3), main = list1[i], log = "y", yaxt= "n", ylim = c(10^(-1), 10^4)
       ,pch = 19, cex = 0.7, ylab = "Phylogenetic Distance", xlab = "Genetic Distance",
       cex.lab = 1.5 , cex.main =1.5
       
  )
  axis(2, at = c(0.1, 1,10,100,1000,10000), labels = c(0.1, 1,10,100,1000,10000), las = 1)
#  Model <- lm(log10(tree_distance$V3) ~ genetic_distance$Distance)
#  legend("bottom" , legend =  bquote(R^2 == .(format(summary(Model)$r.squared, digits = 3))))
}
plot(1, type = "n", axes=FALSE, xlab="", ylab="")
legend("bottom", inset = 0, cex = 1.1, c("?", "Different Phyla", "Same Phylum","Same Class","Same Order","Same Family","Same Genus")
       , fill = c("black", "red", "yellow","gray", "green", "blue", "purple"), horiz = T)
