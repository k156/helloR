#3
midwest = as.data.frame(ggplot2::midwest)
describe(midwest, skew = TRUE, ranges = TRUE, type=3)
aggregate(asian~state, midwest, sum)
apers = aggregate(asian~state, midwest, sum)
tpers = aggregate(total~state, midwest, sum)
#midwest[ ,c(state, (apers$asian/tpers$total)*100)]
#IL에 아시안 인구가 가장 많고 그 다음이 MI 이다. IN이 가장 적다.

#4
colnames(midwest)[5] = "total"
colnames(midwest)[10] = "asian"

#5
asianperc = (midwest$asian/sum(midwest$total))*100
midwest$asianpct = asianperc
hist(midwest$asianpct)

#6
asian_pop = aggregate(asianpct~state, midwest, sum)

#7
mean(midwest$asianpct)
midwest$asianrate = ifelse(midwest$asianpct > mean(midwest$asianpct), "lg", "sm")

#8
qplot(midwest$asianrate)