# 1.다음과 같이 미국의 범죄율을 한번에 작도하시오.
chodata = rownames_to_column(USArrests, var = 'state')
chodata$state = tolower(chodata$state)
usmap = map_data('state')

# m = ggplot(chodata, aes(map_id = state)) + 
#   geom_map(aes(fill = Murder), map = usmap) + 
#   expand_limits(x = usmap$long, y = usmap$lat) +
#   labs(title="", fill = '')
# 
# a = ggplot(chodata, aes(map_id = state)) + 
#   geom_map(aes(fill =Assault), map = usmap) + 
#   expand_limits(x = usmap$long, y = usmap$lat) +
#   labs(title="", fill = '')
# 
# 
# u =  ggplot(chodata, aes(map_id = state)) + 
#   geom_map(aes(fill = UrbanPop), map = usmap) + 
#   expand_limits(x = usmap$long, y = usmap$lat) +
#   labs(title="", fill = '')
# 
# r =  ggplot(chodata, aes(map_id = state)) + 
#   geom_map(aes(fill = Rape), map = usmap) + 
#   expand_limits(x = usmap$long, y = usmap$lat) +
#   labs(title="", fill = '')
# 
# 
# grid.arrange(u, r, ncol=2)
# grid.arrange(grid.arrange(m,a, ncol=2), grid.arrange(u,r, ncol=2), ncol=1) 
# 

# temp =  ggplot(chodata, map_id = state) +
#   geom_map(aes(fill = c(Rape, Assault, Murder, UrbanPop)), map = usmap) +
#   expand_limits(x = usmap$long, y = usmap$lat) +
#   labs(title="", fill = '')
# temp

ggChoropleth(data = chodata,
             aes(fill = c(Murder,Assault, UrbanPop, Rape), map_id = state),
             map = usmap,
             reverse = F,
             interactive = T)



#2. 미국 범죄율의 Rape부분을 단계 구분도로 작성하시오.
# (단, 툴팁은 그림과 같이 표현하고, 클릭시 해당 state의 wikipedia 페이지를 보이도록 HTML로 저장하시오) http://en.wikipedia.org/wiki/wisconsin


tooltips = paste0(
  sprintf("<p><strong>%s</strong></p>", as.character(chodata$state)),
  '<table>',
  '  <tr>',
  round(chodata$Rape), ' /', chodata$UrbanPop *10 , '만',
  '  </tr>',
  '</table>' )

onclick = sprintf('window.open("http://en.wikipedia.org/wiki/%s/")', as.character(chodata$state))

onclick

ggplot(chodata, aes(data = Rape, map_id = state)) +
geom_map_interactive( 
  aes(fill = Rape,
      data_id = state,
      tooltip = stringi::stri_enc_toutf8(tooltips),
      onclick = onclick), 
  map = usmap) +
  expand_limits(x = usmap$long, y = usmap$lat) +
  scale_fill_gradient2('Rape',  low='red', high = "blue", mid = "green") +
  labs(title="USA Rape") -> gg_map
ggiraph(code = print(gg_map))
girafe(ggobj = gg_map)





# 3. 시도별 결핵환자수(kormaps::tbc)를 단계 구분도로 작성하시오.(우리나라)
# (단, 환자수는 2006년부터 2015년 통합, NA인 지역은 0으로 표시할 것)


tbc = kormaps2014::changeCode(tbc)
tbc$NewPts = ifelse(is.na(tbc$NewPt), "0", tbc$NewPts)
tbc$NewPts = as.numeric(tbc$NewPts)
tbc$year = as.numeric(tbc$year)

t = tbc %>%
  group_by(name1,code) %>% 
  filter(year > 2005 & year < 2016) %>% 
  summarise(Pts = sum(NewPts))  %>%  select (code, name1, Pts)


ggChoropleth(data=t,
             aes(fill=Pts, map_id=code),
             map = kormap1,
             title = '시도별 결핵환자수',
             reverse = F,
             interactive = F)


save(kdata, file = 'data/kdata.rda')
