#!/bin/bash

#pipe for data processing  

 ## creating list of DP values 
cut -f1,8 luscinia_vars.vcf | grep -Eo  "DP=[0-9]{1,4}" | tr "DP=" " " > DP

 ##creating list of chromosomes string by string 
cut -f1 luscinia_vars.vcf | grep -v "^#" > chr

 ##merging these lists 
paste chr DP | cut -f1,2 > ready_to_work.csv

 ##Great!
echo 'Success'
