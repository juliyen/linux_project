# head only first two columns without a header
cut -f1-2 luscinia_vars.vcf | grep -v '##' | tail -c +2 > lusc.vcf
## extract DP from initial file
egrep -o 'DP=[^;]*' luscinia_vars.vcf | sed 's/DP=//' > DP1
## paste column name

{ echo -e "DP"; cat DP1; } > DP2  
## merging 
paste lusc.vcf DP2 > rr
## remove useless variables
grep -v "random\|chrAmb\|chrL\|chrUn" rr | sort > rr.tsv
