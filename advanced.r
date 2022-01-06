d <- read.delim("rr.tsv", header=TRUE)
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
