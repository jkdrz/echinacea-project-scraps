# written spring 2012 by jd. happy words list found by kt
# this script pulls data from the final harvest list (ideally it would pull from scan files)
# this will (eventually) generate a folder structure and assign letnos/filenames to that

####################################################
#todo:                                             #
#figure out filename case sensitivity issues       #
#not every filename is in lowercase, which might   #
#end up being problematic, but i'm not sure if R   #
#is case-sensitive when it runs through system()   #
####################################################

#import harvest list, fix letnos (code from scanCompare2012.R)
harvList <- read.csv("I:\\\\Departments\\Research\\EchinaceaCG2011\\2011.CG1.Harvest.List.reconciled.csv", na.strings="")
harvList$letnoHarv <- as.character(harvList$letnoHarv) #you need to make these character vectors
harvList$letnoCorrected <- as.character(harvList$letnoCorrected)
harvList$letnoHarv[complete.cases(harvList$letnoCorrected)] <- harvList$letnoCorrected[complete.cases(harvList$letnoCorrected)]
harvList <- harvList[harvList$gBagCorrected != "NH" , ]

#import the happy word list: we want the lowercase vector
happy <- read.csv("I:\\\\Departments\\Research\\EchinaceaCG2011\\happyWords.csv")

#figure out how many records we have and how many directories we need
length(harvList$letnoHarv) #2892 files, at the top end. 6 in each dir, 482 directories

#we'll add a few dummy directories, just in case. pull out 490 entries
happyList <- sample(happy$lowercase, 490, replace=FALSE)
happyDirs <- rep(happyList, each=6)

# put together the vectors, keeping lets and nos, so i can actually write out files in batches
randomHarvList <- sample(harvList)
happyDirs[1:length(randomHarvList$letnoHarv)]
randomHarvList <- data.frame(randomHarvList, happyDirs[1:length(randomHarvList$letnoHarv)])
names(randomHarvList)[29] <- "happyDirs"
leftoverHappyDirs <- happyDirs[(length(randomHarvList$letnoHarv)+1):length(happyDirs)]

#write out some useful files
#write.csv(randomHarvList, file="C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/2011.CG1.RandomHarvList.csv")
#write.csv(leftoverHappyDirs, file="C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/2011.CG1.LeftoverHappyDirs.csv")

# create directory structure. only run this this first time.
  setwd("C:\\\\cg2011counting\\")
  dirCommands <- paste("mkdir ", "C:\\cg2011counting\\", unique(randomHarvList$happyDirs), sep="")
  write.table(dirCommands, file="mkdirCommands.bat", sep="", row.names=FALSE, col.names=FALSE, quote=FALSE) 
  #this writes hard paths. find the .bat file and double-click it to run it.


