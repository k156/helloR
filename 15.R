# 연관성 분석
install.packages("KoNLP")
install.packages(c("arules", "igraph", "combinat", "arulesViz", "visNetwork"))
library(arules); library(igraph); library(combinat)
nouns = sapply(tyn, unique)
nouns
nouns1 = sapply(nouns, function(x) {
  Filter(function(y='') { nchar(y) <= 4 && nchar(y) > 1 && is.hangul(y) }, x)
})

wtrans = as(nouns1, "transactions")
rules = apriori(wtrans, parameter = list(supp=0.03, conf=0.5))
inspect(sort(rules))

install.packages(c("arulesViz", "visNetwork"))
library(arulesViz); library(visNetwork)

subrules2 <- head(sort(rules, by="lift"), 20)
ig <- plot( subrules2, method="graph", control=list(type="items") )

subrules2 <- head(sort(rules, by="confidence"), 30)
ig <- plot( subrules2, method="graph", control=list(type="items") )

ig_df <- get.data.frame( ig, what = "both" )
visNetwork(
  nodes = data.frame(id = ig_df$vertices$name,
                     value = ig_df$vertices$support, ig_df$vertices),
  edges = ig_df$edges
) %>% visEdges(ig_df$edges) %>%visOptions( highlightNearest = T )



install.packages(c('rvest', 'httr', 'stringr'))
library(rvest); library(httr); library(stringr); library(dplyr)


