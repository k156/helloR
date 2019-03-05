data$group = sample(c('A조','B조','C조'), size= 160, replace=T)

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

