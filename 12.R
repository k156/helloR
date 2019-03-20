install.packages('sqldf')
library(sqldf)

sqldf("select stuno, kor from data where kor < 50 limit 10")
sqldf("select * from data where stuno = '20439'")
sqldf("select kor, count(*) cnt from data where kor < 30 group by kor order by cnt")
sqldf("select cls, (case when cls = '국' then '우리반' else '남의반' end) aa, 
        count(*) cnt from data where kor < 50 group by cls")
sqldf("select cls, avg(kor) from data group by cls")
sqldf("select * from data inner join data2 on data.stuno = data2.stuno")
sqldf("select b.stuno, a.kor from data a inner join data2 b on a.stuno = b.stuno")


###RMySQL

install.packages('RMySQL')
library('RMySQL')

drv = dbDriver("MySQL")
conn = dbConnect(drv, host='35.200.103.240', port=3306, dbname='melondb', user='root', password='1234567')
dbSendQuery(conn, 'set character set utf8') 
rsdf = dbGetQuery(conn, "select * from Song limit 5")
rsdf = changeCode(rsdf)
rsdf

  tryCatch({
  dbBegin(conn)
  x = stringi::stri_enc_toutf8('초록빛')
  dbGetQuery(conn, paste0("update Song set song_name='", x, "' where song_no = '31565593'"))
  dbCommit(conn)
  },

error = function(e) { 
  dbRollback(conn)
  print(paste("Error!!", e)) 
  },

warning = function(w) {
  print(paste("Warining!!", w))
  },

finally = {print("FFFFFF!!")}  )




dbDisconnect(conn)
dbUnloadDriver(drv)

