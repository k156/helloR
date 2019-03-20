# 멜론 탑 100 곡들의 장르와 랭킹간의 관계를 산점도로 작도하시오.


library('RMySQL')
library(sqldf)

drv = dbDriver("MySQL")
conn = dbConnect(drv, host='35.200.103.240', port=3306, dbname='melondb', user='root', password='1234567')


tryCatch({
  dbBegin(conn)
  # result1 = dbGetQuery(conn, "select * from Song")
  # result2 = dbGetQuery(conn, "select song_no, rank from SongRank")
  result = sqldf("select * from Song inner join SongRank on Song.song_no = SongRank.song_no")
},

error = function(e) {
  dbRollback(conn)
  print(paste("Error!!", e))
},

warning = function(w) {
  print(paste("Warining!!", w))
},
finally = {}  )




dbDisconnect(conn)
dbUnloadDriver(drv)

# result = changeCode(result)

result
result = sqldf("select * from result2 inner join result on result.song_no = result2.song_no")





ggplot() + geom_point(data=result, aes(x=genre, y=rank))

