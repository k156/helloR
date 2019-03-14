# 1. mpg데이터에서 연도별 배기량에 따른 통합연비를 꺽은선으로 그리시오
# (단, 2008년은 굵은 선으로 표현하시오)

  d2 = mpg %>% group_by(year, displ) %>%
   summarise(m1 = mean(cty), m2 = mean(hwy))
  d3 = mpg %>% group_by(year, displ) %>% 
    filter(year== 2008) %>%
    summarise(m3 = mean(cty), m4 = mean(hwy))

  ggplot(data= d2, aes(x=displ)) +
  geom_line(aes(group = year, y=m1, color='cty', size = factor(year))) + 
  geom_line(aes(group = year, y=m2, color='hwy',size = factor(year))) +
  scale_colour_manual("", breaks = c("cty", "hwy"),
                      values = c("gray", "pink")) +
    scale_size_manual("", breaks = c("1999", "2008"),
                        values = c(0.5, 2)) +
  xlab("배기량(cc)") +
  scale_y_continuous("연비(M/h)") +
  labs(title = '연도별 통합 연비', subtitle = '(굵은 선은 2008년)')
  
  
  
  2
    # ggplot(d3, aes(x=displ)) +
    # geom_line(aes(y=m3, color='')) + 
    # geom_line(aes(y=m4, color='')) +
    # scale_colour_manual("", breaks = c("cty", "hwy"),
    #                     values = c("blue", "navy")) +
    # xlab("") +
    # scale_y_continuous("")
    # labs(title = '', subtitle = '')
  
# ggplot() +
#     geom_line(data=d2 %>% filter(year == 2008), aes(displ, m1, color = '2008 cty'), size = 1) +
#     geom_line(data=d2 %>% filter(year == 2008), aes(displ, m2, color = '2008 hwy'), size = 1) +
#     geom_line(data=d2 %>% filter(year == 1999), aes(displ, m1, color = '1999 cty')) +
#     geom_line(data=d2 %>% filter(year == 1999), aes(displ, m2, color = '1999 hwy')) +
#     scale_x_continuous("배기량", limits = c(1,7)) +
#     scale_y_continuous("연비", limits = c(5, 50)) +
#     labs(title = '연도별 통합 연비', subtitle = '(굵은 선은 2008년)', colour = "")


# 2. data(성적.csv) 데이터에서 국어 성적이 80점 이상인
# 학생들의 수를 성비가 보이도록 학급별로 막대그래프를 그리시오.

data
kor80 = data %>% filter(kor > 80)


  ggplot(kor80, aes(반)) +
  
  geom_bar(aes(fill=성별),
           width = 0.5) +
    
  labs(y="학생수") +
  
  
  scale_fill_discrete(name = "성별") +     
  labs(title = '국어 우수 학생', subtitle = '80점 이상')



# 3. 국어 성적이 95점 이상인 학생들의
# 점수별 밀도그래프를 그리시오.
  
  kor95 = data %>% filter(kor > 95)

  ggplot(kor95, aes(kor)) +
    geom_density(aes(fill=factor(반)), alpha=0.5) +
    labs(title="반별 국어 우수 학생", subtitle = "(국어 성적 A+)",
         caption="기준점수 >= 95",
         x = "성적",
         y = "밀도",
         fill = "학급")

# 4. midwest데이터에서 전체인구와 아시아계 인구의 관계를 알아보기 위한 그래프를 그리시오. 
# (단, 전체인구는 50만명 이하, 아시아계인구는 1만명 이하만 표시되게)
  

d = midwest %>% filter(total <= 500000, asian <= 10000)
ggplot() +
  geom_point(data=d,
             aes(x=total, y=asian),
             color='blue', size = 1)
  


