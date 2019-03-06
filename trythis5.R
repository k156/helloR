#1
data$group = sample(c('A조','B조','C조'), size= 160, replace=T)


#2
smdt$Math = as.numeric(smdt$Math)
smdt$Korean = as.numeric(smdt$Korean)
smdt$English = as.numeric(smdt$English)
str(smdt)
mean = apply(smdt[, 2:4], MARGIN = 2, FUN = mean)
mean = c('계', mean)
smdt = rbind(smdt, mean)

total = apply(smdt[, 2:4], MARGIN = 1, FUN = sum)
avg = apply(smdt[, 2:4], MARGIN = 1, FUN = mean)
smdt = cbind(smdt, total =total)
smdt = cbind(smdt, avg =avg)




#3
dfsum = cbind( data.frame(no=1:4, year=2016:2019), 
               matrix(round(runif(n=48, min=5, max=9)*10000 )  , ncol=12, dimnames = list(NULL, month.abb) )     ) 
dfsum
meltsum = melt(data = dfsum[,2:13] , id.vars = 'year', variable.name = 'month', value.name = 'saleamt')
meltsum
