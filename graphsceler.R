library(MASS)
library(dplyr)
library(ggplot2)
cdata<- read.csv('dataceler.csv')
summary(cdata)
# compare summary statistics for cost and installs by media source
by(cdata$Cost, cdata$Media_Source, summary)
by(cdata$Installs, cdata$Media_Source, summary)
#adding cost per click metrics to data set 
cdata$cpc <- cdata$Cost / cdata$Clicks
#making a date column
cdata$Date <- as.Date(cdata$Date , format = "%m/%d/%y")
# graphs for dashboard
# October Spend (looking at spend per day)
# here we can see that spend increases on the weekend
c2<-ggplot(cdata,aes(x=cdata$Date, y=cdata$Cost)) + geom_bar( stat="identity",fill = "blue") +labs(title = "October Spend",
       x = "Date", y = "Cost") 
c2
ci<-ggplot(cdata,aes(x=cdata$Date, y=cdata$Installs)) + geom_bar( stat="identity",fill = "blue") +labs(title = "October Installs",
                                                                                                   x = "Date", y = "Installs")
ci
#graph looking at cost and installs by campaign, an effective campaign has minimal spend with a 
# high number of installs we are looking for points in the bottom left of the graphs. 
c3<-ggplot(cdata,aes(x=cdata$Cost, y=cdata$Installs)) + geom_point() +
  facet_wrap(~cdata$Campaign)+labs(title = "Cost per Install",
                                   x = "Cost", y = "Install")
c3
#click by media source
clicks<-ggplot(cdata,aes(x=cdata$Cost, y=cdata$Clicks)) + geom_point() +
  facet_wrap(~cdata$Media_Source)+labs(title = "Cost vs. Clicks",
                                   x = "Cost", y = "Clicks")
clicks
# cost by campaign and date, looks like spend was high on weekend due to campaign 4 
c4 <-ggplot(cdata,aes(x=cdata$Date, y=cdata$Cost)) + geom_bar(stat="identity") +
  facet_wrap(~cdata$Campaign) +labs(title = "Marketing Spend October by Campaign",
                                    x = "Date", y = "Cost")
c4

c5 <-ggplot(cdata,aes(x=cdata$Date, y=cdata$Cost)) + geom_bar(stat="identity") +
  facet_wrap(~cdata$Media_Source) +labs(title = "Marketing Spend October by Media Source",
                                    x = "Date", y = "Cost")
c5
#installs
ci2 <-ggplot(cdata,aes(x=cdata$Date, y=cdata$Installs)) + geom_bar(stat="identity") +
  facet_wrap(~cdata$Media_Source) +labs(title = "Installs October by Media Source",
                                        x = "Date", y = "Installs")
ci2

c6 <-ggplot(cdata,aes(x=cdata$Date, y=cdata$eCPI)) + geom_bar(stat="identity") +
  facet_wrap(~cdata$Media_Source) +labs(title = "CPI by Media Source",
                                        x = "Date", y = "CPI")
c6
# lets look into source 3 
source3 <- filter(cdata, Media_Source=="Source_3")
head(source3)
#investigating further we see that campaign 7 has high CPI we should reevaluate this campaign
s3 <-ggplot(source3,aes(x=Date, y=eCPI)) + geom_bar(stat="identity")+ facet_wrap(~Campaign)
s3
#looking at click data 
s4 <-ggplot(source3,aes(x=Date, y=Clicks)) + geom_bar(stat="identity")+ facet_wrap(~Campaign)
s4

#FORECAST
# only cost and date for forecast
new<- read.csv('forecastceler.csv')
install.packages('forecast', dependencies = TRUE)
install.packages('prophet')
library(forecast)
#prophet is package for forecasting
library(prophet)
new$ds <- as.Date(new$ds , format = "%m/%d/%y")
m <- prophet(new)
# Generate forecast for next 22 days
future <- make_future_dataframe(m, periods = 22)
forecast <- predict(m, future)
#plot
plot(m,forecast)+xlab('Date')+ylab("Cost")
prophet_plot_components(test, forecast)

#total predicted October spend 
a<- sum(forecast$trend)
b<-sum(new$y)
a-b

