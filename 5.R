sample(1:5, size =3)
set.seed(100)
sample(1:5, size = 30, replace = T)
data[sample(1:nrow(data), size = 5, replace= F), ]
data$c1 = sample(c('AA', 'BB'), size=nrow(data), replace=T)
cat(nrow(data), nrow(data[data$c1 == 'AA',]))
data$c1 = sample(c('AA', 'BB'), size=nrow(data), replace=T, prob = c(0.5,0.5))


s = "abc,efg,abc"
sub('abc', 'ttt', s)
gsub('abc', 'ttt', s)
paste(data[1:3, '반'], collapse='**')

outer(month.abb, 2011:2020, paste, sep='-')

grep(pattern='^2', x=data$학번, value = T)



dt1 = as.POSIXct('2019-03-04 09:00')
seq(dt1, as.POSIXct('2019-04-01'), by='day')
seq(dt1, as.POSIXct('2019-04-01'), by='2 hour')
day(dt1) = 15
days_in_month(1:12)
ddays(10)
duration(1000)  
round(as.POSIXct('2019-03-05 18:39:45'), 'min')



for (r in 1:nrow(data)) { print (data[r, 'scout']) }
