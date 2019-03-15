library(dplyr)

data
t = data %>% filter(eng > 90) %>% select('반', '성별') %>% table
data = dplyr::rename(data, kor=국어, sci=과학, eng=영어, art=예체)

barplot(t,
        beside = T,
        border = 'dark blue',
        density = 30,
        angle = 15 + 10*1:2,
        xlab = '학급별 성별', ylab = '영어',
        legend=rownames(t),
        col=heat.colors(4))


  install.packages('gridExtra')
  library(gridExtra)
  g3 = ggplot(mpg, aes(manufacturer)) +
  geom_bar(aes(fill=class),
           width = 0.7) +
  theme(axis.text.x = element_text(angle=45,
                                   vjust=0.6)) +
  labs(title = 'Title', subtitle = 'Sub Title')

  g4 = ggplot(mpg, aes(cty)) +
  geom_density(aes(fill=factor(cyl)), alpha=0.8) +
  labs(title="밀도그래프", subtitle = "실린더수에 따른 시내연비의 밀도그래프",
       caption="Source: ggplot2::mpg",
       x = "도시 연비",
       fill = "실린더수")
  
  
  