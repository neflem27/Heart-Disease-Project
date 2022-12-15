# Prediction of the Existance of Heart Disease (Classification of patients that have or not a Heart Disease)

**Introduction**: Heart disease is the leading cause of death in the United States, causing about 1 in 4 deaths. The term “heart disease” refers to several types of heart conditions. In the United States, the most common type of heart disease is coronary artery disease (CAD), which can lead to heart attack. Heart disease (HD) is one of the most common diseases nowadays, and an early diagnosis of such a disease is a crucial task for many health care providers to prevent their patients for such a disease and to save lives.

**Description**: An early diagnosis of such disease has been sought for many years, and many data analytics tools have been applied to help health care providers to identify some of the early signs of HD.Many tests can be performed on potential patients to take the extra precautions measures to reduce the effect of having such a disease. In this project, you are given a training and a testing data sets. You are expected to perform comparative analysis of different classifiers for the classification of the Heart Disease. Use the training data set in order to build a classification model that correctly classify and or predict HD cases with “minimal” attributes. You will need to validate your classifier performance by submitting your prediction for the testing dataset on kaggle.

# Data Set Description

**Traning Data Set**
- 4200 observations
- 21 predictors and 'HeartDisease' as the outcome
- 2524 missing observations

**Test Data Set**

- 1808 observations
- 20 predictors ('Heart Disease' removed)
- 1148 missing observations

Note: Codebook and data available in repository

# Exploratory Data Analysis

**Missing Categorical Data**: work_type, average_glucose_level, smoking_status, and married have 631 NA's each. The missing information accounts for about 15% of the total data.

<img
  src="https://github.com/neflem27/Heart-Disease-Project/blob/main/HD_NA_MICE.png"
  alt="Alt text"
  title="Training Data"
  style="display: inline-block; margin: 0 auto; max-width: 300px">

**Mislabeling and Unbalanced Categorical Data**: Small instances of some categorical labels, little to no effect (e.g. 'Never worked' with 12 obs). Mislabeling of Gender ('M', 'F', 'Male', 'Female').

**Non-Random Observations**: Numerical predictors such as Cholesterol have 600 observations at zero.

**Outliers and Extreme Values**: Several observations affect the general distribution

<img
  src="https://github.com/neflem27/Heart-Disease-Project/blob/main/HD_BOX_PLOTS.png"
  alt="Alt text"
  title="Box Plots"
  style="display: inline-block; margin: 0 auto; max-width: 300px">
  
**Multicollinearity**: Redundancy among several predictors

# Data Cleaning
## 1. Unbalanced Data (Noise Reduction)

* Unbalanced data leads to overfitting which is why our team initially opted to recode and merge categorical labels/factors with less than 20 intancances with the most common labels within the repective predictor. This reduces dimensionality and increases a variable's weight but for the final model we decided to keep the data as is due to the small size of our training data in order to avoid a loss of significance.

## 2. Fix structural errors

* During the initial EDA there was a single instance of mislabeling throughout the data. The categorical variable "Sex" had four different levels; "Male", "Female", "M", "F" which we recoded into "Male" and "Female" only.

## 3. Filter unwanted outliers

* By looking at the initial box plots, multiple outliers seem to affect the overall numerical distributions of certain variables. To adress the issue we opted to convert (Oldpeak, Cholesterol and Average Glucose Level) into factors to classify these health measurement's into specific categorical ranges. (Not considered for final model)

## 4. Handle Missing Observations

* **MissForest Imputation** used to fill missing observations by using the median/mode imputation. Then the missing values are then marked as 'Predict' and the other observations  as traning rows which are fed into a Random Forest model trained to predict in this case the NA's present in the data. 

# Model & Validation

The general classification problem required machine learning implementation. Train the given Heart Disease data in order to analyse and predict whether or not a pacient suffers from a heart disease. Multiple models were considered and implemented including lda, qda, glm, decision trees and random forest among others. We opted for a tuned Generalized Linear Model due to simple and clear structure which succesfully reach the 80% accuracy cap without overfitting. 

**Note**: The attached R Script contains all of statistical methods considered.

## Step 1: Generalized Linear Model using all predictors

```ruby
m1full <- glm(as.factor(HeartDisease)~.,family = binomial(), data = HD.trainNEW)
summary(m1full)
```

## Step 2: Backward AIC (Dimensionality Reduction)

```ruby
Backward_AIC <- step(m1full,direction="backward", data = HD.trainNEW) 
```

## Step 3: Model and Prediction 
* The resultant glm is further used to predict "Heart Disease" using the traning data, sticking to the general classification threshold of 0.5.

```ruby
pred.prob<- predict(Backward_AIC,HD.trainNEW, type = "response")
head(pred.prob)
glm.pred.new=rep("No",4220)
glm.pred.new[pred.prob>0.5] = "Yes"
```

### Confusion Matrix (Traning Data)

| Heart Disease | No | Yes |
| ----- | ----- | -----|
| No |1914 | 464 |
| Yes | 315 | 1527 |

### Traning Data Error Rate

```ruby
mean(glm.pred.new != factor(HD.trainNEW$HeartDisease)) 
[1] 0.1845972
```

### Testing Data Error Rate

0.18657 public leaderboard (70% of testing data)

0.20258 private leaderboard (30% of testing data)


# Model Diagnostics

<img
  src="https://github.com/neflem27/Heart-Disease-Project/blob/main/HD_Diagnostics.png"
  alt="Alt text"
  title="GLM Assumptions"
  style="display: inline-block; margin: 0 auto; max-width: 200px">
  
 * Based on the diagnostic plots the model violates the assumption of equality of error variance. The normality assumption is met as most points fall on the Normal Q-Q line. The residual vs leverage plot on the other hard shows that there are few influential plots that fall out of Cook's Distance

* Furthermore, the reduced glm model shows no issues of multicollinearity as their VIF scores remain under 5.

| Predictor | GVIF | DF |
| ----- | ----- | -----|
| Cholesterol |1.971870 | 1 |
| MaxHR | 1.073913   | 1 |
| OldPeak |1.532330   | 1 |
| Avg_glucose_level | 2.088878   | 1 |
| Sex |1.012520   | 1 |
| ChestPainType | 2.549829   | 2 |
| FastingBS |1.087064   | 1 |
| ExerciseAngina | 3.469895    | 1 |
| ST_Slope |4.325311   | 1 |
| Residence_type | 1.005567   | 1 |
| stroke |1.437992   | 1 |


# Model Limitations and Ways to Further Improve

## Limitations: 

* GLM tends to oversimplify without appropriate tuning of parameters. This led to a loss in significance once we used variable selection to find the best predictors. 
* This classifier is sensitive to outliers.
* Variables like Old Peak were hard to normalize due to the structure of the data.
* The initial traning data was a bit small, less than 5000 obs.

## Ways to Further Improve:

* Merge data with new information.
* Boost Predictors.
* Redifine categorical boundries.
* Fit more flexible models.





















