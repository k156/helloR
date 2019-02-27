ntof = function(number) {
  f1= factor(number, levels=1:4, labels=LETTERS[c(1,2,15,4)], ordered=T)
  print(as.vector(f1))
}


append = function(v, val) {
 v[length(v)+1] = val
 return()
}

m1 = matrix(1:200, nrow=10, ncol=20)
colnames(m1) = LETTERS[1:20]
rownames(m1) = letters[1:10]
m1

