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
- 1148 missing obserbations

# Exploratory Data Analysis

**Missing Categorical Data**: work_type, average_glucose_level, smoking_status, and married have 631 NA's each. The missing information accounts for about 15% of the total data. 

**Mislabeling and Unbalanced Categorical Data**: Small instances of some categorical labels, little to no effect (e.g. 'Never worked' with 12 obs). Mislabeling of Gender ('M', 'F', 'Male', 'Female').

**Non-Random Observations**: Numerical predictors such as Cholesterol have 600 observations at zero.

**Outliers and Extreme Values**: Several observations affect the general distribution 
**Multicollinearity**: Redundancy among several predictors

# Data Processing & Cleaning

**MissForest Imputation**: Used to fill missing observations by using the median/mode imputation. Then the missing values are then marked as 'Predict' and the other observations  as traning rows which are fed into a Random Forest model trained to predict in this case the NA's present in the data. 

**Simplification of Numerical Distributions**: To adress numerical outliers and extreme values we opted to convert numerical observations to categorical based on specific ranges for Age, Cholesterol, and bmi variables into 2 to 3 level categorical predictors.

**Recoding categorical labels**: Unbalanced data leads to overfitting which is why we merged categorical predictors with less than 20 intancances with the most common label in the repective predictor. Furthermore, the mislabeling of gender was recoded to 'Male' and 'Female' to reduce noise and improve the overall distribution of itself.

# Choosing a Model

The general classification problem required machine learning implementation. Train the given Heart Disease data in order to analyse and predict whether or not a pacient suffers from a heart disease. Multiple models were considered and implemented including lda, qda, glm, decision trees and random forest among others. We opted for a tuned Generalized Linear Model due to simple and clear structure which succesfully reach the 80% accuracy cap without overfitting. 

**Note**: Check the attached R Script for all algorithms.


















