mydata = read.csv('C:/Users/darag/OneDrive/Documents/Statistics Labs/CA Test/FirstYearResults.csv')
str(mydata)
pairs(~studentid + Lab.1 + Christmas.Test + Easter.Test + Lab.2 + parttimejob + maturestudent + Exam.Grade,data=mydata, panel= panel.smooth)

cor(mydata$Lab.1,mydata$Lab.2)
cor.test(mydata$Lab.1,mydata$Lab.2)

cor(mydata$Exam.Grade,mydata$Easter.Test)
cor.test(mydata$Exam.Grade,mydata$Easter.Test)

cor(mydata$Exam.Grade,mydata$Christmas.Test)
cor.test(mydata$Exam.Grade,mydata$Christmas.Test)

cor(mydata$Easter.Test,mydata$Christmas.Test)
cor.test(mydata$Easter.Test,mydata$Christmas.Test)

cor(mydata$Lab.1,mydata$maturestudent)
cor.test(mydata$Lab.1,mydata$maturestudent)

boxplot(Exam.Grade~maturestudent,data=mydata)

boxplot(Exam.Grade~parttimejob,data=mydata)

library(car)
part_time = lm(Exam.Grade~parttimejob, data=mydata)
mature = lm(Exam.Grade~maturestudent, data=mydata)

anova(part_time,mature)

lm_model = lm(Exam.Grade~ Lab.1+Christmas.Test+Easter.Test+Lab.2+parttimejob+maturestudent,mydata)
plot(lm_model,which = 1)
plot(lm_model,which = 2)
plot(lm_model,which = 5)

lm_model2= lm(Exam.Grade~ Christmas.Test+Easter.Test+parttimejob+maturestudent,mydata)
plot(lm_model2,which = 1)
plot(lm_model2,which = 2)
plot(lm_model2,which = 5)

anova(lm_model,lm_model2)
avPlots(lm_model)
avPlots(lm_model2)
summary(lm_model)
summary(lm_model2)
vif(lm_model)
vif(lm_model2)

new_data <- data.frame(
  studentid = 1001,
  Lab.1 = 52,
  Christmas.Test = 58,
  Easter.Test = 60,
  Lab.2 = 55,
  parttimejob = 0,
  Exam.Grade = 60
)
predicted = predict(lm_model2, newdata = new_data)
residuals(lm_model2)
