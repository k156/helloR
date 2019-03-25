install.packages('tm')
install.packages('SnowballC')
library(tm)

getSources()
getReaders()

folder = system.file("texts", "txt", package="tm")
txtSource = DirSource(folder)
class(txtSource); str(txtSource)

doc = VCorpus(txtSource, readerControl = list(language='lat'))
class(doc); summary(doc)

meta(doc)
meta(doc, type = 'local')
inspect(doc)
inspect(doc[1])
doc[[1]][1]

names(doc)
writeCorpus(doc, path="data", filenames = names(doc))


getTransformations()
doc = tm_map(doc, stripWhitespace)


data("crude")
crude
crude[[1]]
crude[[1]][1]

crude = tm_map(crude, stripWhitespace)
crude = tm_map(crude, content_transformer(tolower))
crude = tm_map(crude, removePunctuation)
crude = tm_map(crude, removeWords, stopwords("english"))
crude = tm_map(crude, stripWhitespace)      # 한번 더! (최종 정리) 
crude = tm_map(crude, stemDocument, language="english")

crude[[1]][1]


tdm = TermDocumentMatrix(crude)
rownames(tdm)
tail(as.matrix(tdm))
View(as.matrix(tdm))
dimnames(tdm)
tdm$v
tdm = removeSparseTerms(tdm, 0.8)
tdm; rownames(tdm)
t(tdm)
inspect(tdm)
inspect(tdm[1:5, 1:10])



findFreqTerms(tdm, 20)   # 20회 이상 사용된 단어
findFreqTerms(tdm, 20, 30)    # 20 ~ 30 회 사용된 단어 
findFreqTerms(tdm, 0, 10)     # 10회 이하 사용 단어
findAssocs(tdm, "last", 0.5)       # `last`와 연관성(같이 사용) 50% 이상
findAssocs(tdm, "oil", .7)         # `oil`과 연관성(함께 사용) 70% 이상
findAssocs(tdm, "last", 0.5)


rowSums(as.matrix(tdm))     
wFreq = sort(rowSums(as.matrix(tdm)), decreasing = T)     # 빈도수 높은 순
names(wFreq)
wFreq > 10    
subset(wFreq, wFreq > 10)   # 빈도수 10회 초과 단어들만!

# RColorBrewer - 팔레트
install.packages('RColorBrewer')
library(RColorBrewer)
display.brewer.all()
brewer.pal.info
pa = brewer.pal(8, 'Blues')
darks = brewer.pal(8, 'Dark2') 


# wordcloud - 워드 클라우드
install.packages("wordcloud")
library(wordcloud)

set.seed(100)

wordcloud(words = names(wFreq), freq=wFreq, min.freq = 10,
          random.order = F, colors = darks)




#TryThis. Doc으로 wordcloud 만들기
doc[[1]][1]
doc = tm_map(doc, stripWhitespace)
doc = tm_map(doc, content_transformer(tolower))
doc = tm_map(doc, removePunctuation)
# doc = tm_map(doc, removeWords, stopwords("latin")) -------없음
doc = tm_map(doc, stripWhitespace)      # 한번 더! (최종 정리) 
doc = tm_map(doc, stemDocument, language="latin")
tdmdoc = TermDocumentMatrix(doc)
dFreq = sort(rowSums(as.matrix(tdmdoc)), decreasing = T)  

wordcloud(words = names(dFreq), freq=dFreq, min.freq = 10,
          random.order = F, colors = darks)


