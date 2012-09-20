#this script is used to combine the seperated cg counts in the 2011 8000 batch
#other counts are on one datasheet, and don't need to be combined in this way
#don't just run the whole script. it shouldn't clobber anything, but still.

###############################################################################
#this code works for the 8000s, which is the old datasheet. look below for code
#that works with the newer landscape, 3-person-on-one-page datasheets,
#which are for everything other than the 8000s
###############################################################################
#read in the data
setwd("C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/count2011_work/")
de1 <- read.csv("2011.CG1.countData8000-de1.csv", na.strings="") #r seems to read
de2 <- read.csv("2011.CG1.countData8000-de2.csv", na.strings="") #these in strangely
de3 <- read.csv("2011.CG1.countData8000-de3.csv", na.strings="")

#drop empty rows
de1 <- de1[complete.cases(de1$happyDirs8000),]
de2 <- de2[complete.cases(de2$happyDirs8000),]
de3 <- de3[complete.cases(de3$happyDirs8000),]

#drop extraneous vectors from the data.frame
de1 <- subset(de1, select=-c(X,count.1,countInit.1,countDate.1,countNote.1))
de2 <- subset(de2, select=-c(X,count.1,countInit.1,countDate.1,countNote.1))
de3 <- subset(de3, select=-c(X,count.1,countInit.1,countDate.1,countNote.1))

#merge the files into one dataframe
count8000 <- merge(de1,de2, by="filename")
count8000 <- merge(count8000, de3, by="filename")
#pull out the counts so I can use rowMeans
counts    <- data.frame(count8000$count.x, count8000$count.y, count8000$count)
countMedians <- ceiling((1/6)*(apply(counts, 1, median, na.rm=TRUE)))
count8000$numToWeigh <- countMedians

output <- data.frame(count8000$filename, count8000$numToWeigh)
names(output) <- c("filename", "numToWeigh")
let <- toupper(substr(output$filename, 5, 6)) #make things uppercase, since harvList uses uppercase
no  <- substr(output$filename, 1, 4)
letno <- paste(let, no, sep= "-")
output$letno <- letno
write.csv(output, "c:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/170_randomize/randomize2011/randomize2011_work/2011.CG1.8000CountsToRandomize.csv")

###############################################################################
#this code works for the newer landscape, 3-person-on-one-page datasheets,
#which are for everything other than the 8000s
###############################################################################
#read in the data
setwd("C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/count2011_work/")
de1 <- read.csv("2011.CG1.countData6000.csv", na.strings="") #r seems to read
names(de1)[1:2] <- c("fileName", "folder") #i accidentally reversed these. same for 4000s, i bet

#drop empty rows
de1 <- de1[complete.cases(de1$folder),]

#pull out the counts so I can use rowMeans
counts    <- data.frame(de1$count1, de1$count2, de1$count3)
countMedians <- ceiling((1/6)*(apply(counts, 1, median, na.rm=TRUE)))
de1$numToWeigh <- countMedians

output <- data.frame(de1$fileName, de1$numToWeigh)
names(output) <- c("fileName", "numToWeigh")
let <- toupper(substr(output$fileName, 5, 6)) #make things uppercase, since harvList uses uppercase
no  <- substr(output$fileName, 1, 4)
letno <- paste(let, no, sep= "-")
output$letno <- letno
write.csv(output, "c:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/170_randomize/randomize2011/randomize2011_work/2011.CG1.6000CountsToRandomize.csv")

