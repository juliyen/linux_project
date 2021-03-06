# linux_project
## Here we go

# pipeline for data processing  named pipe.sh goes first, it contain following steps:

 ## creating list of DP values 
```
cut -f1,8 luscinia_vars.vcf | grep -Eo  "DP=[0-9]{1,4}" | tr "DP=" " " > DP
```

 ## creating list of chromosomes string by string 
```
cut -f1 luscinia_vars.vcf | grep -v "^#" > chr
```
 ## merging these lists 
```
paste chr DP | cut -f1,2 > ready_to_work.csv
```
## removing unmapped and not needed references
```
grep -v "random\|chrAmb\|chrL\|chrUn" ready_to_work.csv | sort  > ready_to_work.csv
```
 ## Great!
```
echo 'Success'
```
# Graphics session. For this you need to use R (Rstudio) with package ggplot2
```
library(ggplot2) 
```
## read table

```
d <- read.delim("ready_to_work.csv", header=FALSE)
```
#### plot wg distribution of DP 
```
ggplot(d, aes(V2)) + labs(x = "DP")+ geom_bar()
```
![image](https://user-images.githubusercontent.com/79110719/148211159-c0daf55d-9662-4040-8660-e8bd5d92cfdf.png)

#### plot DP per chr 

```
ggplot(d, aes(V1)) + 
  geom_bar() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+ labs(x = "DP")
```
![image](https://user-images.githubusercontent.com/79110719/148211234-bef2d8f1-b5fb-4666-8c3c-17fcd1b7fab8.png)


## create list of chr
```
n <- d$V1 
```
## get unique names 
```
one <- unique(n)
```
## create pdf with distributions for each chromosome
``` 
pdf(file = "chromosomes.pdf")

S <-data.frame()
## create "for cycle" to plot all the graphs at one run 
for (i in 1:length(one)){
  l <- subset(d, V1 == one[i])
#hist of DP distributions
hist(l$V2, main = paste(one[i]), xlab ="DP")  
}
dev.off()
```
## pdf with graphs per chr is in the results

# in advanced pipeline and r script you may prepare position distribution of reads 

```
d %>%
  group_by(CHROM) %>%
  mutate(POS_block = plyr::round_any(POS, 1e4)) ->
  dc
dc %>%
  group_by(CHROM, POS_block) %>%
  summarise(DP = n()) %>%
  ggplot(aes(POS_block, DP)) +
  geom_line() +
  facet_wrap(~CHROM, ncol = 8)+ 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
```
![image](https://user-images.githubusercontent.com/79110719/148412461-d4b51888-f1a0-4161-ab6d-5f75069a86c8.png)
