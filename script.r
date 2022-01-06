## R
## R
library(ggplot2)

#read table

d <- read.delim("ready_to_work.csv", header=FALSE)
#### plot wg distribution of DP 
ggplot(d, aes(V2)) + labs(x = "DP")+ geom_bar()

#### plot DP per chr 

ggplot(d, aes(V1)) + 
  geom_bar() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))


# create list of chr
n <- d$V1 

#get unique names 
one <- unique(n)

#create pdf with distributions for each chromosome
pdf(file = "chromosomes.pdf")

S <-data.frame()
#create "for cycle" to plot each graph at one run 
for (i in 1:length(one)){
  l <- subset(d, V1 == one[i])
  #hist of DP distributions
  hist(l$V2, main = paste(one[i]), xlab ="DP")  
}
dev.off()
