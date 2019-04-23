install.packages("twitteR")
install.packages("plyr")
install.packages("syuzhet")
install.packages("ggplot2")
install.packages("tm")

library("twitteR")
library("plyr")
library("syuzhet")
library("ggplot2")
library("tm")

consumer_key <- "unique_the details for the keys are unique for unique users"
consumer_secret <- "unique_the details for the keys are unique for unique users"
access_token <- "unique_the details for the keys are unique for unique users"
access_secret <- "unique_the details for the keys are unique for unique users"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


Tweets <- searchTwitter("Hotstar", lang="en", n=100, resultType="recent")

Tweetstext <- sapply(Tweets, function(x) x$getText())

#Remove RT text, etc.
Tweetstext1 = gsub("(RT|via)((?:\\b\\W*@\\w+)*)","", Tweetstext)

#Remove html links
Tweetstext2 = gsub("http[^[:blank:]]+","", Tweetstext1)

#Remove Tweet names
Tweetstext3 = gsub("@\\w+","", Tweetstext2)

#Remove punctuations
Tweetstext4 = gsub("[[:punct:]]", " ", Tweetstext3)

#Remove punctuations
Tweetstext5 = gsub("[^[:alnum:]]", " ", Tweetstext4)

Sentiment <- get_nrc_sentiment(Tweetstext5)


SentimentScores <- data.frame(colSums(Sentiment))
names(SentimentScores) <- "Score"
SentimentScores <- cbind("sentiment" = rownames(SentimentScores), SentimentScores)
rownames(SentimentScores) <- NULL
ggplot(data = SentimentScores, aes(x =  sentiment, y = Score)) + geom_bar(aes(fill = sentiment), stat =  "identity") + theme(legend.position = "none") + xlab("Sentiment") + ylab("Score") + ggtitle("Total Sentiment Score based on top Tweets")

