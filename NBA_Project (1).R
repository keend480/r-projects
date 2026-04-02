library(corrplot)
library(MASS)
library(dplyr)
library(ggplot2)

#Load the data
nba_ori <- read.csv('nba_new.csv')
nba <- nba_ori[c(1:21)]

#Exclude Rookie from the data
nba <- subset(nba, Rookie.Scale. == 0)
nba <- nba[-19]

#Correlation Graph
nba_cor <- cor(nba[3:20], use="pairwise", method="spearman")
res1 <- cor.mtest(nba_cor, conf.level = .95)
corrplot(nba_cor, p.mat = res1$p, method="square", 
         insig = "label_sig", pch.col = "white", # Add * to statistical significant one
         tl.col = "blue", tl.srt = 90, # Text label color and rotation
         type = "upper", diag = FALSE)  # hide correlation coefficient on the principal diagonal


###Part B
#Linear Regression with all variables
salary_all <- lm(Salary~.-Max-Player.Name-Player.ID,data=nba)
summary(salary_all)

#Variables selection
stepAIC(salary_all, direction="both")

#Linear Regression with essential variables
salary_essential <- lm(formula = Salary ~ REB + VORP + eFG + OR. + TO. + Usage + Age, data = nba)
summary(salary_essential)

#Value Check Function
value_determination <- function(playerdata){
  player_pred <- predict(salary_essential, newdata = playerdata)
  if (playerdata$VORP >= mean(nba$VORP) && playerdata$Salary > salary_pred) {print("Expensive Talent")}
  else if(playerdata$VORP >= mean(nba$VORP) && playerdata$Salary <= salary_pred) {print("Good Investment")}
  else if(playerdata$VORP < mean(nba$VORP) && playerdata$Salary > salary_pred) {print("Over Price")}
  else if(playerdata$VORP < mean(nba$VORP) && playerdata$Salary <= salary_pred) {print("Bench Warmer")}
}

#Test Function: Input Player Name to see the result 
playerdata <- subset(nba_ori, nba_ori$Player.Name=="LeBron James", select = c(1:21))
value_determination(playerdata)

#Prediction for the player
player_pred <- predict(salary_essential, newdata = playerdata)
print(c(playerdata$Salary, salary_pred))

#Predicted salary for all players
salary_pred <- predict(salary_essential, newdata = nba_ori)

#Add predicted salary to dataset
nba_new <- cbind(nba_ori, salary_pred)

#Plot the relation between Actual and Predicted Salary
plot(nba_ori$Salary, salary_pred)
salary_diff <- scale(nba_new$Salary)-scale(nba_new$salary_pred)
nba_new <- cbind(nba_new, salary_diff)
ggplot(nba_new,aes(x=scale(Salary), y=scale(salary_pred), color=salary_diff))+
  geom_point()+scale_color_gradient2(midpoint=0, low="brown", mid="grey", high="blue", space ="Lab" )+
  labs (title="Actual vs Predicted Salary", x="Actual Salary (Scaled)", y="Predicted Salary")


###Part C
# Find the Good Investment Players
good_investment <- subset(nba_new, VORP > 0.80047 & Salary <= salary_pred)
good_investment %>% arrange(desc(VORP))
good_investment[1:10,]
#now that we have a top ten ranking, select players whose salary totals combined will be less than 42 mil
# Giannis + Luka +Trae
25842697 + 7683360 + 6273000
