sepdata = read.delim('data/sep.txt', sep='#')
sepdata
str(sepdata)
View(sepdata)
sepdata$name = as.character(sepdata$name)


tsvdata = read.table("data/tcv.tsv", sep='\t')
tsvdata = read.table("data/tcv.tsv", sep='\t', header=TRUE)
tsvdata = read.table("data/tcv.tsv", sep='\t', header=T, stringsAsFactors=F)

install.packages('readxl')
library('readxl')
mtx = read_excel('data/meltop100.xlsx')
save(mtx, file = 'data/meltop100.rda')
load('data/meltop100.rda')
mtx
