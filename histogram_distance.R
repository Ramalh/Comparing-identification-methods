distances <- read.csv('../GenDisCal_outputs/sorted_karl6.csv')

list1 <- c("Different_Phyla", "Same_Phylum", "Same_Class", "Same_Order", "Same_Family", "Same_Genus")
list2 <- c( rgb(0,0.5,0.5,0.5),rgb(0,0,1,0.5),rgb(0,1,0,0.5),rgb(0,1,1,0.5),rgb(1,0,0,0.5),rgb(1,0,1,0.5))

ax <- pretty(c(0,1), n=500)

par(mar = c(5,6,1,1))

len <- length(list1)

list3 <- rep(NA, len)

for (i in 1:len) {
  if (!is.null(distances$Distance[distances$Expected_Relation == list1[[i]]])) {
    h <- hist(distances$Distance[distances$Expected_Relation == list1[[i]]], plot = F,  breaks = ax)
    h$counts <- h$counts/length(distances$Distance)
    list3[i] <- max(h$counts)
  }
}

max1 = max(list3)

x = 1
for (i in 1:len) {
  if (!is.null(distances$Distance[distances$Expected_Relation == list1[[i]]])) {
    
    h <- hist(distances$Distance[distances$Expected_Relation == list1[[i]]], plot = F,  breaks = ax)
    h$counts <- h$counts/length(distances$Distance)
    if (x == 1) {
      plot(h, xlim = c(0,1), ylim = c(0, max1), col = list2[[i]], main = "Distribution of Karlin 6 distance", ylab = "", xlab = "Genetic Distances", border = list2[[i]]
           ,cex.lab =1.5, cex.main = 1.5, las = 1)
    }
    plot(h, col = list2[[i]], add = T, ylim = c(0, max1), border = list2[[i]])
    
    x = x + 1
  }
  x = x + 1
}
mtext("Ratio", side = 2, line= 3.5, cex = 1.5)

legend("topleft", legend = list1, 
       fill = list2,
       cex = 1.1, bty = "n", xpd= T)
