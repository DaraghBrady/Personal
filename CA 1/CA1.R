#a
setwd("C:/Users/darag/OneDrive/Documents/Statistics Labs/CA 1")
library(MASS)
data(Melanoma)

#b
ncol(Melanoma)
nrow(Melanoma)

#c
str(Melanoma)

#d
hist(Melanoma$age, main= 'Age Histogram', xlab= 'Age',col='blue')
barplot(table(Melanoma$sex), main= 'Sex Distribution', xlab = 'Sex', ylab= 'Frequency', col= 'yellow')
hist(Melanoma$thickness, main= 'Thickness Histogram', xlab= 'Thickness', col= 'red')
barplot(table(Melanoma$status), main= 'Status Distribution', xlab='Status', ylab= 'Frequency', col='magenta')

#e
summary(Melanoma$age)
summary(Melanoma$year)
summary(Melanoma$ulcer)
summary(Melanoma$thickness)

#f
plot(Melanoma$age, Melanoma$thickness, main= 'Scatterplot Age vs Thickness', xlab= 'Age', ylab= 'Thickness')
table(Melanoma$sex, Melanoma$status)
boxplot(Melanoma$age~Melanoma$status, xlab= 'Status', ylab= 'Age', main= 'Box plot of Age by Status')
boxplot(Melanoma$age~Melanoma$year, xlab= 'Year', ylab= 'Age', main= 'Box plot of Age by Year')

#g
library(ggplot2)
ggplot(data= Melanoma) + geom_point(aes(x= age, y= thickness))+ geom_point(aes(x= thickness, y= ulcer))+geom_point(aes(x= age, y= ulcer))
ggplot(data= Melanoma) + geom_point(aes(x= age, y= thickness, color= ulcer))

#h
cor(Melanoma$age,Melanoma$ulcer, method='pearson')
cor(Melanoma$age,Melanoma$ulcer, method='spearman')
cor(Melanoma$age,Melanoma$thickness, method='pearson')
cor(Melanoma$age,Melanoma$thickness, method='spearman')
cor(Melanoma$age,Melanoma$status, method='pearson')
cor(Melanoma$age,Melanoma$status, method='spearman')
cor(Melanoma$ulcer,Melanoma$thickness, method='pearson')
cor(Melanoma$ulcer,Melanoma$thickness, method='spearman')
cor(Melanoma$status,Melanoma$time, method='pearson')
cor(Melanoma$status,Melanoma$time, method='spearman')

#i
cor.test(Melanoma$thickness,Melanoma$ulcer)

#j
linearmodel=lm(Melanoma$ulcer ~ Melanoma$thickness)
summary(linearmodel)
