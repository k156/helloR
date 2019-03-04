#1
sort((mpg$cty + mpg$hwy), decreasing = T)

#2
num2 = aggregate((mpg$cty + mpg$hwy)~year+fl, mpg, mean)
num2[order(num2$'year'), ]