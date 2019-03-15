df1 = data.frame(column1=11:15, column2=LETTERS[1:5])
class(df1)
str(df1)
df2 = data[1:10, 1:6]

install.packages('data.table')

library('data.table')

start = Sys.t0ime()
# read.csv('data/성적.csv')
fread('data/성적.csv', encoding = 'UTF-8')
Sys.time() - start