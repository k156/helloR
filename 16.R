###1. 네이버 뉴스 1면의 기사들을 수집하시오.

newsUrl= "https://news.naver.com/main/home.nhn"
html = read_html(newsUrl)
links1 = html_attr(html_nodes(html, 'div[class=newsnow] > ul > li > div > a'), 'href')
links2 = html_attr(html_nodes(html, 'div.com_list > div > ul > li > a'), 'href')

for (i in links2) {
links1[length(links1) + 1] = i
links1
}

links = links1[!is.na(links1)]       # NA 제거
news = list()       # 변수 초기화

for (i in 1:length(links)) {
  try({
    htxt = read_html(links[i])
    comments = html_nodes(htxt, '#articleBodyContents')
    get_news = repair_encoding(html_text(comments))   # repair_encoding(html_text(comments), from='utf-8')
    news[i] = str_trim(get_news)
  }, silent = F)
}

#children써서 기자 이름 이후 다 지우기


removeStopword = function(t) {
  t = gsub("http[s]?://[[:alnum:].\\/]+", "", t) 
  t = gsub("&[[:alnum:]]+;", "", t)
  t = gsub("@[[:alnum:]]+", "", t)
  t = gsub("@[[:alnum:]]+[:]?", "", t)
  t = gsub("[ㄱ-ㅎㅏ-ㅣ]","",t)
  t = gsub("[[:punct:]]", " " , t)  
  t = gsub("\\s{2,}", " ", t)
  t = gsub("[[:cntrl:]]", "", t) 
  t = gsub("https", "", t)
  t = gsub("RT", "", t)
  t = gsub('[[:alnum:]]+@[[:alnum:].]+', '', t)  # email 제거
  t = gsub('기자', '', t)
  # mac: emo 제거s
  gsub('\\p{So}|\\p{Cn}', '', t, perl = TRUE)
}


for (i in 1:length(news)) {
  news[[i]][1] = removeStopword(news[[i]][1])
  news[[i]][1] = gsub("flash 오류를 우회하기 위한 함수 추가function flash removeCallback", "", news[[i]][1])
}

news



###2.수집 된 뉴스로 WordCloud를 작도하시오.

library(twitteR); library(RCurl); library(RJSONIO); library(stringr)
library(streamR); library(ROAuth); library(rJava); library(KoNLP); library(dplyr)
library(RColorBrewer); library(wordcloud)

newsn = sapply(news, extractNoun, USE.NAMES = F)
newss = sapply(newsn, function(x) {
  Filter(function(y) { nchar(y) <= 4 && nchar(y) > 1 && is.hangul(y) }, x)
})



newsn1 = table(unlist(newss))

newsn2 = head(sort(newsn1, decreasing = T), 100)


pal = brewer.pal(9, "Set1")
wordcloud(names(newsn2), freq=newsn2, scale=c(5,0.5), rot.per=0.25,
          min.freq = 1, random.order = F, random.color = T, colors = pal)




###3. 수집 된 뉴스로 연관성분석을 하시오.
library(arules); library(igraph); library(combinat)
library(arulesViz); library(visNetwork)

newsu = sapply(news, unique)
newsn = sapply(newsu, extractNoun, USE.NAMES = F)
newss = sapply(newsn, function(x) {
  Filter(function(y) { nchar(y) <= 4 && nchar(y) > 1 && is.hangul(y) }, x)
})



ntrans = as(newss, "transactions")
rules2 = apriori(ntrans, parameter = list(supp=0.2, conf=0.5))
inspect(sort(rules2))



subrules3 <- head(sort(rules2, by="lift"), 20)
ig2 <- plot( subrules3, method="graph", control=list(type="items") )

subrules3 <- head(sort(rules2, by="confidence"), 30)
ig2 <- plot( subrules3, method="graph", control=list(type="items") )

ig_df2 <- get.data.frame(ig2, what = "both" )
visNetwork(
  nodes = data.frame(id = ig_df2$vertices$name,
                     value = ig_df2$vertices$support, ig_df2$vertices),
  edges = ig_df2$edges
) %>% visEdges(ig_df2$edges) %>%visOptions( highlightNearest = T )


