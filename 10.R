x = 1:5; y = 1:3
z = outer(x, y, function(x,y) { x + y })   
z

x = seq(-10, 10, length=30); y = x
f = function(x, y) {
  r = sqrt(x^2 + y^2)
  return (10 * sin(r) / r)
}
z = outer(x, y, f)
persp(x, y, z, theta = 45, phi = 30, expand = 0.5, col='lightblue',
      ltheta = 120, shade = 0.75, ticktype='detailed',
      xlab = 'X', ylab = 'Y', zlab = "Sinc(r)")

head(USArrests) 
str(USArrests)   
rownames(USArrests)
library(tibble)  
chodata = rownames_to_column(USArrests, var = 'state')
chodata$state = tolower(chodata$state)
chodata







install.packages('ggiraphExtra')
install.packages('maps')
install.packages('mapproj')
library(ggiraphExtra)
library(ggplot2)
library(dplyr)
usmap = map_data('state') 

ggChoropleth(data=chodata,
             aes(fill=Murder, map_id=state),
             map = usmap,
             title = '..',
             reverse = F,
             interactive = T)

