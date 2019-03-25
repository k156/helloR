install.packages('ggiraphExtra')
install.packages('maps')

library(ggiraphExtra)

ggChoropleth(data=chodata,
             aes(fill=Murder, map_id=state),
             map = usmap,
             title = '..',
             reverse = F,
             interactive = T)


ggplot(chodata, aes(map_id = state)) + 
  geom_map(aes(fill = Murder), map = usmap) + 
  expand_limits(x = usmap$long, y = usmap$lat) +
  labs(title="USA Murder", fill = '살인')

scale_fill_gradient2('살인', low="blue", mid='',high='')


tooltips = paste0(
  sprintf("<p><strong>%s</strong></p>", as.character(chodata$state)),
  '<table>',
  '  <tr>',
  '    <td>인구(만)</td>',
  sprintf('<td>%.0f</td>', chodata$UrbanPop * 10),
  '  </tr>',
  '  <tr>',
  '    <td>살인</td>',
  sprintf('<td>%.0f</td>', chodata$Murder),
  '  </tr>',
  '  <tr>',
  '    <td>폭력</td>',
  sprintf('<td>%.0f</td>', chodata$Assault),
  '  </tr>',
  '</table>' )


onclick = sprintf("alert(\"%s\")", as.character(chodata$state))

install.packages('stringi')
library(stringi)
library(ggplot2)
library(dplyr)
library(ggiraph)
 ggplot(chodata, aes(data = Murder, map_id = state)) +
  geom_map_interactive( 
    aes(fill = Murder,
        data_id = state,
        tooltip = stringi::stri_enc_toutf8(tooltips),
        onclick = onclick), 
    map = usmap) +
  expand_limits(x = usmap$long, y = usmap$lat) +
  scale_fill_gradient2('살인', low='red', high = "blue", mid = "green") +
  labs(title="USA Murder") -> gg_map
  ggiraph(code = print(gg_map))
  girafe(ggobj = gg_map)

  
  
  
  ####### 우리나라

  install.packages('devtools')
  devtools::install_github("cardiomoon/kormaps2014")
  library(kormaps2014)  


  setlib = function () {
    library(devtools)
    library(stringi)
    library(ggplot2)
    library(dplyr)
    library(ggiraph)
    library(ggiraphExtra)
    library(kormaps2014) 
    library(plotly)
    library(dygraphs)
    library(xts)  
    library(gridExtra)
  }
  setlib()

 # rm(kdata)
#  kdata = kormaps2014::changeCode(korpop1)
  kdata = korpop1
  head(kdata)
  colnames(kdata)
  kdata = kdata %>% rename (pop = 총인구_명)
  kdata = kdata %>% rename(area = 행정구역별_읍면동)
  kdata$area = stringi::stri_enc_toutf8(kdata$area)
  
  ggChoropleth(data=kdata, 
               aes(fill = pop, map_id = code, tooltip = area),
               map = kormap1,
               interactive = T)  

  ggplot(kdata, aes(data = pop, map_id = code)) +
    geom_map( aes(fill = pop), map = kormap1) + 
    expand_limits(x = kormap1$long, y = kormap1$lat) +
    scale_fill_gradient2('인구', low='darkblue') +
    xlab('경도') + ylab('위도') + 
    labs(title="시도별 인구")
  
  
  
  install.packages('plotly')
  
  t = ggplot(data, aes(eng, kor)) +
    geom_point(aes(color=eng, size=kor), alpha=0.3)
  
  ggplotly(t)
  

  
  
  install.packages('dygraphs')
  
  library(xts)  
  
  
  economics
  ue = xts(economics$unemploy, order.by = economics$date)  
  ue
  dygraph(ue)
  dygraph(ue) %>% dyRangeSelector()
  psave = xts(economics$psavert, order.by = economics$date)
 # dygraph(cbind(ue, psave))  
  ue2 = xts(economics$unemploy / 1000, order.by = economics$date)
  pu = cbind(ue2, psave)  
  colnames(pu) = c('unemploy', 'saverate')
  dygraph(pu) %>% dyRangeSelector()
  
  
  ggsave
  
  
  