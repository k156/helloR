Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_191/")

install.packages(c("twitteR", "RCurl", "RJSONIO", "stringr", "streamR", "ROAuth"))
library(twitteR); library(RCurl); library(RJSONIO); library(stringr)
library(streamR); library(ROAuth)

#keys are from './data/api_keys.R'
save(API_key, file= './data/api_key.rda')
save(API_secret, file= 'data/api_secret.rda')
save(token, file = 'data/token.rda')
save(token_secret, file= 'data/token_secret.rda')
setup_twitter_oauth(API_key, API_secret, token, token_secret)

install.packages(c("rJava", "memoise", "KoNLP"))
library(rJava)
library(KoNLP)


searchTwitter(enc2utf8('승리'), n=100, lan='ko')


tweets = searchTwitter(enc2utf8('승리'), n=100, lan='ko', 
                       since='2019-03-11', until='2019-03-31')
tdf = twListToDF(tweets)

nrow(tdf)
colnames(tdf)

library(dplyr)
head(tdf)
# tdf %>% filter(!isRetweet) %>% filter(favoriteCount > 2) %>% select(text)
tdf %>% filter(regexpr('광고',text) == -1)     # 특정 단어 포함된 문서 제거
tw = unique(tdf$text)       # 중복 방지하고 text 만 남기자
# tdf = tdf[regexpr('제거할 단어', tdf$text) == -1]  #특정 단어 제거

# 3. 불용어 제거
tw = gsub("[[:cntrl:]]", "", tw)                      # 제어문자(\n, \t등) 제거
tw = gsub("http[s]?://[[:alnum:].\\/]+", "", tw)     # link 제거
tw = gsub("&[[:alnum:]]+;", "", tw)            # escape(&amp; &lt;등) 제거
tw = gsub("@[[:alnum:]]+[:]?", "", tw)             # 트위터 계정 부분 제거
tw = gsub("[ㄱ-ㅎㅏ-ㅣ]","",tw)                   # 한글 불용어(ㅋㅋㅎㅎ ㅠㅜ등) 제거
tw = gsub('<.*>', '', enc2native(tw))          # EMO(/U00000f등) 제거 (windows)
tw = gsub("\\s{2,}", " ", tw)                  # 2개이상 공백을 한개의 공백으로 처리
tw = gsub("https", "", tw)
tw = gsub("RT", "", tw)   
tw = gsub("[[:punct:]]", "", tw)               # 특수 문자 제거 (앞의 처리 때문에 마지막에 해야 함!!)

nouns = sapply(tdf, extractNoun, USE.NAMES = F)

wc = sapply(tw, extractNoun, USE.NAMES = F)
wc1 = table(unlist(wc))

wc2 = head(sort(wc1, decreasing = T), 100)
wc2

library(RColorBrewer)
library(wordcloud)

pal = brewer.pal(9, "Set1")
wordcloud(names(wc2), freq=wc2, scale=c(5,0.5), rot.per=0.25, 
            min.freq = 1, random.order = F, random.color = T, colors = pal)





tyt = searchTwitter(enc2utf8('태용'), n=100, lan='ko',
                       since='2019-03-01', until='2019-03-25')
ty = twListToDF(tyt)
ty = unique(ty$text)

ty1

ty

ty1 = gsub("\\U[[:alnum:]]", "", ty)     

ty = gsub("[[:cntrl:]]", "", ty)                      # 제어문자(\n, \t등) 제거
ty = gsub("http[s]?://[[:alnum:].\\/]+", "", ty)     # link 제거
ty = gsub("&[[:alnum:]]+;", "", ty)            # escape(&amp; &lt;등) 제거
ty = gsub("@[[:alnum:]]+[:]?", "", ty)             # 트위터 계정 부분 제거
ty = gsub("[ㄱ-ㅎㅏ-ㅣ]","",ty)                   # 한글 불용어(ㅋㅋㅎㅎ ㅠㅜ등) 제거
ty = gsub("<.*>", "", enc2native(ty))      # EMO(/U00000f등) 제거 (windows)
ty = gsub("\\s{2,}", " ", ty)                  # 2개이상 공백을 한개의 공백으로 처리
ty = gsub("https", "", ty)
ty = gsub("RT.*_?.*:", "", ty)
ty = gsub("RT", "", ty)
ty = gsub("[[:punct:]]", "", ty)               # 특수 문자 제거 (앞의 처리 때문에 마지막에 해야 함!!)

buildDictionary(ext_dic = "woorimalsam", user_dic=data.frame("태용","ncn"),replace_usr_dic = T)

tyn = sapply(ty, extractNoun, USE.NAMES = F)
tyn1 = table(unlist(tyn))

tyn2 = head(sort(tyn1, decreasing = T), 100)
tyn2

pal = brewer.pal(9, "Set1")
wordcloud(names(tyn2), freq=tyn2, scale=c(5,0.5), rot.per=0.25,
          min.freq = 1, random.order = F, random.color = T, colors = pal)


