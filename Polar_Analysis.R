## This file is for analyzing data that has been converted to polar coordinates in MATLAB

## Required packages (download from Packages -> install package)
# ggplot2
# doBy
# lme4polydat<-Mouse
# popbio



### Import Data and assign any factors (such as treatment) and the level order

poldat <- read.delim("~/Desktop/PolarScripts&SampleData/Polar.txt", stringsAsFactors=FALSE)
poldat$Status = factor(poldat$Status, levels = c("Live","Dead"))

## Angle from 0 to 360
for(n in 1:nrow(poldat)) 
{
  if (poldat$angle[n]<0)
  {
    poldat$angle[n]=poldat$angle[n]+360
  }
}


### Visualize to look at patterns of radius by angle, stratfied by status 

library(ggplot2)

quartz()

t <- qplot(angle,radius, data = poldat, color = Status, shape = Status)

t + theme_bw()

## Specify a subset across angles:

polangle <- subset(poldat, poldat$angle >160 & poldat$angle <270 )


## ANOVA Analysis & Box plot
aov.out <- aov(radius ~ Status + Error(indiv), data = polangle)
summary(aov.out)


quartz() 
boxplot(radius ~Status, data = polangle,ylab='Radius')




## Logistic Regression: Does radius predict survival?


survr <- glm(Status ~ radius, family = binomial, polangle)
summary(survr)

##Visualization

library(popbio)
quartz()
logi.hist.plot(polangle$radius, polangle$StatusNum, logi.mod = 1, boxp = FALSE, counts = FALSE, type = "hist", col = "gray")
