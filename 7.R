dfsum = cbind( data.frame(yno=1:4, year=2016:2019), 
               matrix(round(runif(16), 3) * 1000, ncol=4, dimnames = list(NULL, paste0('Q', 1:4))))

sales = cbind( data.frame(no=1:12, year=2016:2019), 
               matrix(round(runif(144), 3) * 100000, ncol=12, dimnames = list(NULL, month.abb)) )


left_join(sales, dfsum, by=c('year' = 'year'))
right_join(sales, dfsum, by=c('year' = 'year'))
# inner_join, semi_join
inner_join(sales, dfsum, by=c('year' = 'year', 'no' = 'yno'))
semi_join(sales, dfsum, by=c('year' = 'year', 'no' = 'yno'))
# full_join, anti_join
full_join(sales, dfsum, by=c('year' = 'year', 'no' = 'yno'))
anti_join(sales, dfsum, by=c('no' = 'yno'))