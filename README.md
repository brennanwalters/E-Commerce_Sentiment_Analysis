
![Screen Shot 2021-05-24 at 6 40 41 PM](https://user-images.githubusercontent.com/54850909/119419354-b1a3a780-bcbf-11eb-96d7-f5c3ef3565b1.png)

# Table of Contents
* Introduction
* Data Description
* Sentiment Analysis
* Prediction
* Conclusion

# Introduction

Sentiment Analysis Motivation:

* **What:** Sentiment analysis is a way of interpreting the overall mood of text
* **Why:** It saves time, labor, and provides consistent classification of text
* **Uses:** writing aids, analyzing survey responses, classifying social media posts,  and many more applications
* It is important in helping e-commerce businesses make sense of the feedback they receive daily in the form of customer reviews

Goals for this analysis:

* Write R code to calculate the sentiment of a large collection of text data
* Perform sentiment analysis of customer review data
* Predict customer recommendations based on the sentiment of the review

# Data Description

Source: [Kaggle](https://www.kaggle.com/nicapotato/womens-ecommerce-clothing-reviews)

Because this is real commercial data, The reviewers and the company name have been made anonymous. There are 23,486 Observations and 9 features, including:

* Age of the reviewer
* Title of the review
* Review text
* Rating given by the reviewer
* Whether or not the reviewer recommended the product (1=Yes, 0=No)
* Number of positive words used
* Division, class, and department of the product

## Data cleaning

I used the tm (text mining) library in R to make the review text lowercase and to remove punctuation, stop words, and extra whitespace. From there, I constructed a term-document matrix to structure the data, then determined most frequnetly used words.

Here is a sample review before cleaning the text: \
![Screen Shot 2020-04-26 at 8 49 44 PM](https://user-images.githubusercontent.com/54850909/119419496-05ae8c00-bcc0-11eb-8836-fcdf2156ad18.png)
\
Here is the same review after cleaning the text: \
![Screen Shot 2020-04-26 at 8 50 32 PM](https://user-images.githubusercontent.com/54850909/119419529-13641180-bcc0-11eb-8057-12fea95f5d67.png)


### Word cloud visualizing most frequently used words
<img src="https://user-images.githubusercontent.com/54850909/119419732-85d4f180-bcc0-11eb-8f7e-f640d2099682.png" width="400" height="400">

# Sentiment Analysis
To calculate the sentiment of each review, I used the *sentimentr* library. The function *sentiment()* from *sentimentr* takes in text and returns a sentiment score which is a decimal that can be positive or negative. A positive sentiment score indicates positive emotion, a negative sentiment score indicates negative emotion, and a sentiment score of zero indicates neutral emotion. Below is a function that loops through the data and returns the sentiment scores for all of the reviews. I then added these sentiment scores to the data to use for prediction.

![Screen Shot 2020-04-26 at 10 56 26 PM](https://user-images.githubusercontent.com/54850909/119419448-eb74ae00-bcbf-11eb-9708-7d0be01ae036.png)

### Distribution of Sentiment Score
![image](https://user-images.githubusercontent.com/54850909/120730292-cb56a300-c4a6-11eb-995b-71e63aeace6d.png)


# Prediction

**Goal:** predict whether or not a customer recommended a product based on the sentiment score of their review

![Screen Shot 2021-06-03 at 4 38 30 PM](https://user-images.githubusercontent.com/54850909/120715476-3e9dec00-c48a-11eb-842b-2723e980d36a.png)


## Logistic Regression

### Model Summary
![Screen Shot 2021-06-03 at 7 43 44 PM](https://user-images.githubusercontent.com/54850909/120729251-423e6c80-c4a4-11eb-8e9f-585c2eab9e65.png)

* McFadden's pseudo R2 of 0.19 indicates that this is likely not a bad model, at least by this metric, but could be stronger

### Confusion Matrix
![Screen Shot 2021-06-03 at 3 30 54 PM](https://user-images.githubusercontent.com/54850909/120729331-82055400-c4a4-11eb-90ad-908406cc1d13.png)


**Accuracy** = 0.8417542 \
**Precision** = 0.9777893 \
**Recall** = 0.852063 

## Naive Bayes

### Confusion Matrix
![Screen Shot 2021-06-03 at 7 47 04 PM](https://user-images.githubusercontent.com/54850909/120729333-83cf1780-c4a4-11eb-8f00-9f1bc16df05d.png)


**Accuracy** = 0.8370707 \
**Precision** = 0.9874311 \
**Recall** = 0.8421439 


# Conclusion



