library(ggplot2)
library(dplyr)

sgdpisa_c = read.csv('sgdpisa_c.csv',fileEncoding="UTF-8-BOM")
str(sgdpisa_c)

sgdpisa_c <- na_if(sgdpisa_c,"No Response")
sgdpisa_c <- na_if(sgdpisa_c,"")
sgdpisa_c <- na_if(sgdpisa_c,"Invalid")
sgdpisa_c <- na_if(sgdpisa_c,"Not Applicable")

sgdpisa_c$TOT_OSCH_STUDYTIME <- as.numeric(as.character(sgdpisa_c$TOT_OSCH_STUDYTIME))
sgdpisa_c$TOT_SCH_PRD_WK <- as.numeric(as.character(sgdpisa_c$TOT_SCH_PRD_WK))
sgdpisa_c$MINS_CLASS_PRD <- as.numeric(as.character(sgdpisa_c$MINS_CLASS_PRD))
sgdpisa_c$Age <- as.numeric(as.character(sgdpisa_c$Age))

group_by(sgdpisa_c,DAD_EDU) %>% summarise (count=n(),meanstudy=mean(TOT_OSCH_STUDYTIME,na.rm=TRUE))


# fn for one continuous variable
F1 <- function(x, ...) {
  graph1 <- ggplot(sgdpisa_c, aes(x, ...)) + geom_histogram(binwidth = 3) #+ xlab(NULL) + ylab(NULL)
  return(graph1)
}

# fn for one discrete variable
F2 <- function(x, ...) {
  graph2 <- ggplot(sgdpisa_c, aes(x)) + geom_bar() #+ labs(title = "Frequency of x",x = "x",y = "Frequency")
  return(graph2)
}

# fn for discrete x and continous y
F3 <- function(x, y, ...) {
  graph3 <- ggplot(sgdpisa_c, aes(x, y)) + geom_boxplot(aes(fill = x)) #+ xlab("XXX") + ylab("YYY") + ggtitle("ZZZ")
  return(graph3)
}

# fn for discrete x and discrete y
F4 <- function(x, y, ...) {
  graph4 <- ggplot(sgdpisa_c, aes(x, y)) + geom_count() #+ xlab(NULL) + ylab(NULL)
  return(graph4)
}

#F1(sgdpisa_c$TOT_OSCH_STUDYTIME)
#F2(sgdpisa_c$GENDER)
#F2(sgdpisa_c$CNT)
#F3(sgdpisa_c$CNT, sgdpisa_c$TOT_OSCH_STUDYTIME)
#F4(sgdpisa_c$CNT, sgdpisa_c$OWN_ROOM)
