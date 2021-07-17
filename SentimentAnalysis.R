# E-Commerce Sentiment Analysis

dat = read.csv('E-Commerce-Reviews.csv',header=TRUE)
dat[1] = NULL
head(dat)
str(dat)

library(tm)
corpus = iconv(dat$Review.Text, to="utf-8-mac")
corpus = Corpus(VectorSource(corpus))
inspect(corpus[2:3])

# Clean the text
corpus = tm_map(corpus, tolower)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeNumbers)
corpus = tm_map(corpus,removeWords, stopwords('english'))
corpus = tm_map(corpus, removeWords, c("just","look","also","think","really","will","bit","usually","wear","ordered","looks","little","can","got","bought","medium","tried"))
corpus_clean = tm_map(corpus, stripWhitespace)
inspect(corpus_clean[2:5])

# Convert to stuctured data
str = TermDocumentMatrix(corpus_clean)
str = as.matrix(str)
dim(str)
#str[1:10, 1:20]

# Examine structured data
words = rowSums(str)
summary(words)
hist(words)

# Wordcloud
library(wordcloud)
frequent = subset(words, words>=2050)
frequent = sort(frequent, decreasing = TRUE)
length(frequent)
wordcloud(words=names(frequent), freq=frequent,)


### Sentiment Analysis ###

library(sentimentr)
# Function to calculate sentiment score for every review
get_sentiment = function(text) {
  n = length(text)
  sent = rep(0,n)
  for (i in 1:n) {
    df = sentiment(get_sentences(text[i]))
    sent[i] = mean(df$sentiment)
  }
  return(sent)
}


# Test get_sentiment
testText = c("I don't like that.","I'm glad I bought this", "the shirt didn't fit. I'm not a fan of that color either","I might buy this again","I absolutely adore this dress")
get_sentiment(testText)


dim(reviews)
unique(reviews$Department.Name)
unique(reviews$Division.Name)
unique(reviews$Class.Name)

# Data types
reviews$Review.Text = as.character(reviews$Review.Text)
reviews$Rating = as.factor(reviews$Rating)
reviews$Department.Name = as.factor(reviews$Department.Name)
reviews$Division.Name = as.factor(reviews$Division.Name)
reviews$Class.Name = as.factor(reviews$Class.Name)
reviews$Recommended.IND = as.factor(reviews$Recommended.IND)

# Get the sentiment for reviews
start_time = Sys.time() 
sent = get_sentiment(reviews$Review.Text)
end_time = Sys.time()
end_time - start_time # Runtime

sent[1:5]
summary(sent)

# Check for same number of rows
length(sent)
dim(reviews)

# Add sentiment score to data
reviews$sent_score = sent
hist(reviews$sent_score)

### Classification ###

library(ggplot2)
ggplot(reviews, aes(x=Recommended.IND,fill=Recommended.IND)) +
  geom_bar() + 
  theme_minimal() + 
  theme(legend.title = element_blank()) +
  labs(title="Recommendations",x="Recommended",y="Count")

# Training and testing data
s_size = floor(0.7*nrow(reviews))
train_ind = sample(seq_len(nrow(reviews)), size = s_size)
train = reviews[train_ind,]
test = reviews[-train_ind,]

dim(train)
dim(test)
head(train)

# Fit logistic regression model
library(jtools)
fit = glm(Recommended.IND~sent_score, data=train, family=binomial)
summ(fit)

# Test data
fit.predict = predict(fit, test)
length(fit.predict)
dim(test)

# Confusion matrix
library(regclass)
confusion_matrix(fit, DATA = test)
(252+5679)/(252+986+129+5679) #accuracy
(5679)/(5679+129) #precision
(5679)/(5679+986) #recall

# Naive Bayes classification
library(e1071)
bayes = naiveBayes(Recommended.IND~sent_score, data=train)
bayes.predict = predict(bayes,test)

length(bayes.predict)
which(is.na(bayes.predict))
table(test$Recommended.IND,bayes.predict)

# Confusion matrix
confusionMatrix(table(test$Recommended.IND,bayes.predict))
(163+5735)/(163+1075+73+5735) #accuracy
(5735)/(5735+73) #precision
(5735)/(5735+1075) #recall

# Test models using made up review
Review.Text = c("I love the style and fabric of this shirt, but it was much wider than I expected. I don't like the way it flairs out at the bottom. I still like the shirt but next time I will wear it with the bottom tucked in.")
sent_score = c(get_sentiment(Review.Text))
sent_score
Recommended.IND = c(1)
myDat = data.frame(Review.Text, Recommended.IND, sent_score)

predict(fit, myDat)
predict(bayes, myDat)
