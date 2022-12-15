# Heart Disease Final Model (Github)

setwd("C:/Users/domin/OneDrive/Escritorio/Stats Major Classes/Stats 101C")
HD.train <- read.csv("HDtrainNew.csv")
HD.test <- read.csv("HDtestNoYNew.csv")
dim(HD.train) # 4220 21
dim(HD.test) # 1808 20

# Part 1:Explanatory Data Analysis (Raw Data)

# Structure
str(HD.train) # 4 integers, 13 character, 4 numerical
# Missing Values
sum(is.na(HD.train)) # There are 2524 missing values 
library(mice)
md.pattern(HD.train, rotate.names = T)
# Mislabeling
table(HD.train$Sex)
# Density Plots & Box Plots
library(ggplot2)
library(gridExtra)
{dplot1 <- ggplot(data = HD.train, aes(x=Age ,color=HeartDisease)) + geom_density()
dplot2 <- ggplot(data = HD.train, aes(x=Oldpeak ,color=HeartDisease)) + geom_density()
dplot3 <- ggplot(data = HD.train, aes(x=avg_glucose_level ,color=HeartDisease)) + geom_density()
dplot4 <- ggplot(data = HD.train, aes(x=bmi ,color=HeartDisease)) + geom_density()}
grid.arrange(dplot1, dplot2, dplot3, dplot4)
{bplot1 <- ggplot(data = HD.train, aes(x = RestingBP, color = HeartDisease)) + geom_boxplot()
bplot2 <- ggplot(data = HD.train, aes(x = MaxHR, color = HeartDisease)) + geom_boxplot()
bplot3 <- ggplot(data = HD.train, aes(x = avg_glucose_level, color = HeartDisease)) + geom_boxplot()
bplot4 <- ggplot(data = HD.train, aes(x = Cholesterol, color = HeartDisease)) + geom_boxplot()
bplot5 <- ggplot(data = HD.train, aes(x = Oldpeak, color = HeartDisease)) + geom_boxplot()
bplot6 <- ggplot(data = HD.train, aes(x = bmi, color = HeartDisease)) + geom_boxplot()}
grid.arrange(bplot1, bplot2, bplot3, bplot4, bplot5, bplot6)

# Part 2: Data Cleaning 

#MISSFOREST Imputation: 
#Note: Only works with Factors
library(missForest)
#Train
nt = HD.train[,c(3,5,6,9,11,17,18)] # Moving numerical vars aside
{aa = factor(HD.train$Sex)
bb = factor(HD.train$ChestPainType)
cc = factor(HD.train$FastingBS)
dd = factor(HD.train$RestingECG)
ee = factor(HD.train$ExerciseAngina)
ff = factor(HD.train$ST_Slope)
gg = factor(HD.train$hypertension)
hh = factor(HD.train$ever_married)
ii = factor(HD.train$work_type)
jj = factor(HD.train$Residence_type)
kk = factor(HD.train$smoking_status)
ll = factor(HD.train$stroke)
mm = factor(HD.train$HeartDisease)}
#Test
ntest = HD.test[,c(3,5,6,9,11,17,18)]
{aaa = factor(HD.test$Sex)
  bbb = factor(HD.test$ChestPainType)
  ccc = factor(HD.test$FastingBS)
  ddd = factor(HD.test$RestingECG)
  eee = factor(HD.test$ExerciseAngina)
  fff = factor(HD.test$ST_Slope)
  ggg = factor(HD.test$hypertension)
  hhh = factor(HD.test$ever_married)
  iii = factor(HD.test$work_type)
  jjj = factor(HD.test$Residence_type)
  kkk = factor(HD.test$smoking_status)
  lll = factor(HD.test$stroke)}
#Binding Train, ob excluded
train_1 = cbind(nt, Sex = aa, ChestPainType = bb,FastingBS = cc, RestingECG = dd, ExerciseAngina = ee,ST_Slope = ff,hypertension = gg,ever_married = hh, work_type = ii,Residence_type =  jj,smoking_status =  kk, stroke = ll, HeartDisease =  mm)
imp_HD.T <- missForest(train_1)
HD.trainNEW <- as.data.frame(imp_HD.T$ximp)
#Binding Test
test_1 = cbind(ntest, Sex = aaa, ChestPainType = bbb,FastingBS = ccc, RestingECG = ddd, ExerciseAngina = eee,ST_Slope = fff,hypertension = ggg,ever_married = hhh, work_type = iii,Residence_type =  jjj,smoking_status =  kkk, stroke = lll)
imp_HD.Te <- missForest(test_1)
HD.testNEW <- as.data.frame(imp_HD.Te$ximp)
#Dimension and NA Check
dim(HD.trainNEW)
dim(HD.testNEW)  
sum(is.na(HD.trainNEW))# Imputed data has NO missing observations
sum(is.na(HD.testNEW))# Imputed data has NO missing observations

#Re-coding (Reduces noise of small categorical instances & improves data distribution)

library(car)
HD.trainNEW$Sex <- recode(HD.trainNEW$Sex, "'F'= 'Female'; 'M'= 'Male'; 'Other' = 'Male'")
HD.testNEW$Sex <- recode(HD.testNEW$Sex, "'F'= 'Female'; 'M'= 'Male'; 'Other' = 'Male'")
table(HD.trainNEW$Sex)
table(HD.testNEW$Sex)

HD.trainNEW$ChestPainType <- recode(HD.trainNEW$ChestPainType, "'TA' = 'ASY'")
HD.testNEW$ChestPainType <- recode(HD.testNEW$ChestPainType, "'TA' = 'ASY'")
table(HD.testNEW$ChestPainType)
table(HD.trainNEW$ChestPainType) 

HD.trainNEW$ST_Slope <- recode(HD.trainNEW$ST_Slope, "'Down' = 'Flat'")
HD.testNEW$ST_Slope <- recode(HD.testNEW$ST_Slope, "'Down' = 'Flat'")
table(HD.testNEW$ST_Slope)
table(HD.trainNEW$ST_Slope) 

HD.trainNEW$work_type <- recode(HD.trainNEW$work_type," 'Never_worked' = 'children' ") 
HD.testNEW$work_type <- recode(HD.testNEW$work_type," 'Never_worked' = 'children' ") 
table(HD.trainNEW$work_type) 
table(HD.testNEW$work_type)


# Part 3: Modeling & Validation

# Step 1:GLM model using all predictors
m1full <- glm(as.factor(HeartDisease)~.,family = binomial(), data = HD.trainNEW)
summary(m1full)

# Step 2: Backward AIC
Backward_AIC <- step(m1full,direction="backward", data = HD.trainNEW) 
summary(Backward_AIC)

# Step 3: Prediction using new model & Error Rate

pred.prob<- predict(Backward_AIC,HD.trainNEW, type = "response")
head(pred.prob)
glm.pred.new=rep("No",4220)
#Classification threshold of 0.5
glm.pred.new[pred.prob>0.5] = "Yes"
#Confusion matrix
table(glm.pred.new, factor(HD.trainNEW$HeartDisease))
#Error rate
mean(glm.pred.new != factor(HD.trainNEW$HeartDisease)) 
#We have predicted heart disease with a success percentage of 0.8145

# Diagnostic Plots

par(mfrow = c(2, 2))
plot(Backward_AIC)

# Multicollinearity Check (Below 5 is good)
vif(Backward_AIC)









