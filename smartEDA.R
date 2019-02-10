library(smbinning)
library(SmartEDA)
data("mtcars")
# Example 1
## Read mtcars data
# Target variable "am" - Transmission (0 = automatic, 1 = manual)
# Summary statistics
ExpCatStat(mtcars,Target="am",Label="Transmission",result = "Stat",clim=10,nlim=5,Pclass=1)
# Inforamtion value for categorical Independent variables
ExpCatStat(mtcars,Target="am",Label="Transmission",result = "IV",clim=10,nlim=5,Pclass=1)



data <- data %>% mutate(Label= ifelse(!is.na(data$ActivatedWorkOrders),1,0))
ExpCatStat(data,Target=data$Label,result = "Stat",clim=10,nlim=5,Pclass=1)
data$Label

library(dplyr)
sample <- data %>% sample_n(size = 10000)
eda.stat <- ExpCatStat(sample,Target="CandidateSubmissions",result = "Stat",clim=55,nlim=5,Pclass=1)
eda.num.stat <- ExpNumStat(sample, gp="Label",Nlim = 10,Outlier = TRUE)

ExpCatViz(sample,gp="Label",fname='cat_var_eda.pdf',clim=40,col=NULL,
          margin=1,Page=NULL,Flip=F,sample=NULL,rdata=FALSE,value=NULL)
