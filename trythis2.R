library('readxl')
mtp = read_excel('data/meltop100.xlsx')
mtp = mtp[-101,]
mtp

save(mtp, file = 'data/meltop100.rda')
meltop = read.csv("data/meltop100.csv", encoding= 'utf-8')
meltop


data[data$학번 == 10337, ]
data$학번 == 10337
km = data[data$국어 > 90 & data$수학 > 90, ]
km[order(km$수학), ]
