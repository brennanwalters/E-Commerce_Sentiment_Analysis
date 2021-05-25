
![Screen Shot 2021-05-24 at 6 40 41 PM](https://user-images.githubusercontent.com/54850909/119419354-b1a3a780-bcbf-11eb-96d7-f5c3ef3565b1.png)

## Introduction

Sentiment Analysis Motivation:

* **What:** Sentiment analysis is a way of interpreting the overall mood of text
* **Why:** It saves time, labor, and provides consistent classification of text
* **Uses:** writing aids, analyzing survey responses, classifying social media posts,  and many more applications
* It is important in helping e-commerce businesses make sense of the feedback they receive daily in the form of customer reviews

## Data Description

Source: https://www.kaggle.com/nicapotato/womens-ecommerce-clothing-reviews

Because this is real commercial data, The reviewers and the company name have been made anonymous. There are 23,486 Observations and 9 features, including:

* Age of the reviewer
* Title of the review
* Review text
* Rating given by the reviewer
* Whether or not the reviewer recommended the product
* Number of positive words used
* Division, class, and department of the product

Goals for this analysis:
* Use some R code to calculate the sentiment of a large collection of text data
* Perform sentiment analysis of customer review data
* Predict product rating based on the sentiment of the review


## Data cleaning

I used the tm (text mining) library in R to make the review text lowercase and to remove punctuation, stop words, and extra whitespace. From there, I constructed a term-document matrix to structure the data, then determined most frequnetly used words.


Here is a sample review before cleaning the text: \
![Screen Shot 2020-04-26 at 8 49 44 PM](https://user-images.githubusercontent.com/54850909/119419496-05ae8c00-bcc0-11eb-8836-fcdf2156ad18.png)
\
Here is the same review after cleaning the text: \
![Screen Shot 2020-04-26 at 8 50 32 PM](https://user-images.githubusercontent.com/54850909/119419529-13641180-bcc0-11eb-8057-12fea95f5d67.png)
<br/>
### Word cloud visualizing most frequently used words
<img src="https://user-images.githubusercontent.com/54850909/119419732-85d4f180-bcc0-11eb-8f7e-f640d2099682.png" width="400" height="400">

## Sentiment Analysis
To calculate the sentiment of each review, I used the *sentimentr* library. The function *sentiment()* from *sentimentr* takes in text and returns a sentiment score which is a decimal that can be positive or negative. A positive sentiment score indicates positive emotion, a negative sentiment score indicates negative emotion, and a sentiment score of zero indicates neutral emotion. Below is a function that loops through the data and returns the sentiment scores for all of the reviews.

![Screen Shot 2020-04-26 at 10 56 26 PM](https://user-images.githubusercontent.com/54850909/119419448-eb74ae00-bcbf-11eb-9708-7d0be01ae036.png)

I then added these sentiment scores to the data
