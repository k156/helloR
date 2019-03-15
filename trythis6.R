#1. mpg데이터에서 차종(class)가 suv, compact인 자동차의 모델과 연비관련 변수만 출력하세요.

mpg %>% filter(class %in% c('suv', 'compact')) %>% select(model, cty, hwy, class)


#2. mpg데이터에서 고속도로연비(hwy) 1 ~ 5위에 해당하는 자동차의 데이터를 출력하세요.

mpg %>% arrange(desc(hwy)) %>% head(5)


#3. 회사별로 suv 차들의 통합연비(평균) 구해 1 ~ 5위를 출력하세요.

attach(mpg)

mpg %>% filter(class == 'suv') %>% 
group_by(manufacturer) %>% 
summarize(efficiency = mean(cty+hwy))  %>%
arrange(desc(efficiency)) %>% head(5)
          
detach(mpg)

#4. 다음과 같이 연료별 가격이 정해져 있을 때, mpg에 fl_price라는 컬럼을 추가하세요.

fl   type    price
c   CNG     1.33
d   diesel  1.02
e   E85     0.92
p   Premi   1.99
r   Reqular 1.22



