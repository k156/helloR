
# 4. midwest데이터에서 전체인구와 아시아계 인구의 관계를 알아보기 위한 그래프를 그리시오. 
# (단, 전체인구는 50만명 이하, 아시아계인구는 1만명 이하만 표시되게)

```{r, echo=TRUE}
d = midwest %>% filter(total <= 500000, asian <= 10000)
ggplot() +
  geom_point(data=d,
             aes(x=total, y=asian),
             color='blue', size = 1)

```
