## This file is for analyzing data that has been converted to polar coordinates in MATLAB

## Required packages (download from Packages -> install package)
# ggplot2
# doBy
# lme4polydat<-Mouse
# popbio



### Import Data and assign any factors (such as treatment) and the level order

poldat <- read.delim("Polar.txt", stringsAsFactors=FALSE)
poldat$Status = factor(poldat$Status, levels = c("Live","Dead"))

## Angle from 0 to 360
for(n in 1:nrow(poldat)) 
{
  if (poldat$angle[n]<0)
  {
    poldat$angle[n]=poldat$angle[n]+360
  }
}


## Specify a subset across angles:


poldat8<-subset(poldat,poldat$timept==8)
RBC8=poldat$y[as.numeric(row.names(poldat8))]
RBC=poldat$y
## ANOVA Analysis & Box plot
# Day 8
aov.out <- aov(RBC8 ~ Status + Error(indiv), data = poltime)
summary(aov.out)

#ALL
aov.out <- aov(RBC~ Status + Error(indiv), data = poldat)
summary(aov.out)


quartz() 
boxplot(RBC8 ~Status, data = poldat8,ylab='RBC')
quartz() 
boxplot(RBC ~Status, data = poldat,ylab='RBC')



