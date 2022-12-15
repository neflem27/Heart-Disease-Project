# Prediction of the Existance of Heart Disease (Classification of patients that have or not a Heart Disease)

**Introduction**: Heart disease is the leading cause of death in the United States, causing about 1 in 4 deaths. The term “heart disease” refers to several types of heart conditions. In the United States, the most common type of heart disease is coronary artery disease (CAD), which can lead to heart attack. Heart disease (HD) is one of the most common diseases nowadays, and an early diagnosis of such a disease is a crucial task for many health care providers to prevent their patients for such a disease and to save lives.

**Description**: An early diagnosis of such disease has been sought for many years, and many data analytics tools have been applied to help health care providers to identify some of the early signs of HD.Many tests can be performed on potential patients to take the extra precautions measures to reduce the effect of having such a disease. In this project, you are given a training and a testing data sets. You are expected to perform comparative analysis of different classifiers for the classification of the Heart Disease. Use the training data set in order to build a classification model that correctly classify and or predict HD cases with “minimal” attributes. You will need to validate your classifier performance by submitting your prediction for the testing dataset on kaggle.

# Data Set Description

**Traning Data Set**
- 4200 observations
- 20 predictors and 'HeartDisease' as the outcome
- 2524 missing observations

**Test Data Set**

- 1808 observations
- 20 predictors ('Heart Disease' removed)
- 1148 missing observations


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

* Unbalanced data leads to overfitting which is why our team opted to recode and merge categorical labels/factors with less than 20 intancances with the most common labels within the repective predictor. This reduces dimensionality and increases a variable's weight.

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

## Step 2: Backward AIC (Dimensionality Reduction)

## Step 3: Model and Prediction 

















