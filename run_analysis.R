


Libs<-c("BAS", "broom", "car", "dplyr", "expss", "GGally", "ggExtra", "ggplot2", "ggpubr", "ggrepel", "Hmisc", "hrbrthemes", "knitr", "matrixStats", "Metrics", "nlme", "purrr", "readr", "rmarkdown", "rstatix", "statsr", "stringr", "tibble", "tidyr", "viridis")

lapply(Libs, library, character.only=TRUE)

setwd("C:/Users/kaley/Documents/R/Data_Science/Cleaning Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")


test<-read.table(file="test/X_test.txt")
train<-read.table(file="train/X_train.txt")
colnames<-read.table(file="features.txt")
test.samples<-read.table(file="test/subject_test.txt")
train.samples<-read.table(file="train/subject_train.txt")

Col.Names<-c(as.character(colnames$V2))
Test.Samples<-c(as.character(test.samples$V1))
Train.Samples<-c(as.character(train.samples$V1))
colnames(test)<-Col.Names
colnames(train)<-Col.Names

test.means<-grep("mean", names(test), value=TRUE)
test.std<-grep("std", names(test), value=TRUE)
test.data<-test %>% select(test.means, test.std)
test.data<-test.data %>% mutate(ID=paste("test",Test.Samples, sep="_"))
test.data<-test.data %>% relocate(ID)

train.means<-grep("mean", names(train), value=TRUE)
train.std<-grep("std", names(train), value=TRUE)
train.data<-train %>% select(train.means, train.std)
train.data<-train.data %>% mutate(ID=paste("train",Train.Samples, sep="_"))
train.data<-train.data %>% relocate(ID)

combined_data<-merge(test.data, train.data, all=TRUE)

Tidy_data<-combined_data %>% group_by(ID) %>% summarise_all(mean)

write.table(Tidy_data,file.path("Tidy_Data.txt"),row.name=FALSE) 