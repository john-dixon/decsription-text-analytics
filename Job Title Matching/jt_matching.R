##source data
library(RODBC)
library(dplyr)
library(sqldf)
conn <- odbcDriverConnect('driver={SQL Server};server=amtrowsqldev05\\tab_sqa;database=AnalyticsMapping;uid=tab_reader;pwd=T*M8V/6tTO/k')
sql <- "select distinct JOB_TTLE_MAPP FROM [AnalyticsMapping].[dbo].[mpRequisitionJobTitle]"
titles <- sqlQuery(conn, sql)
colnames(titles) <- "Title"
# Method 1: using the native R adist
# To make sure we are dealing with charts
source1.devices <- titles
source2.devices <- titles
source1.devices$name <-as.character(titles$Title)
source2.devices$name<- as.character(titles$Title)

dist.name<-adist(source1.devices$name,source2.devices$name, partial = TRUE, ignore.case = TRUE)

# We now take the pairs with the minimum distance
min.name<-apply(dist.name, 1, max)

cmatch.s1.s2<-NULL  
for(i in 1:nrow(dist.name))
{
  s2.i<-match(min.name[i],dist.name[i,])
  s1.i<-i
  match.s1.s2<-rbind(data.frame(s2.i=s2.i,s1.i=s1.i,s2name=source2.devices[s2.i,]$name, s1name=source1.devices[s1.i,]$name, adist=min.name[i]),match.s1.s2)
}
# and we then can have a look at the results
View(match.s1.s2)
