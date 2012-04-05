# written spring 2012 by jd. happy words list found by kt
# this script pulls data from the final harvest list (ideally it would pull from scan files)
# this will (eventually) generate a folder structure and assign letnos/filenames to that

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

harvList$no <- as.integer(substr(harvList$letnoHarv, 4, 7))
inb1and2 <- harvList$no < 9000 & harvList$no >= 8000

h8000 <- harvList[inb1and2, ]

#we'll add a few dummy directories, just in case. pull out 490 entries
happyList <- sample(happy$lowercase, 230, replace=FALSE)
happyDirs <- rep(happyList, each=6)

# put together the vectors, keeping lets and nos, so i can actually write out files in batches

h8000 <- h8000[sample(1: dim(h8000)[1]), ]
happyDirs8000 <- happyDirs[1:230]
randomHarvList8000 <- data.frame(h8000, happyDirs8000)
names(randomHarvList8000)[29] <- "happyDirs"
leftoverHappyDirs <- happyDirs[(length(randomHarvList8000$letnoHarv)+1):length(happyDirs)]

#write out some useful files
#write.csv(randomHarvList, file="C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/2011.CG1.RandomHarvList.csv")
#write.csv(leftoverHappyDirs, file="C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/2011.CG1.LeftoverHappyDirs.csv")

# create directory structure. only run this this first time.
  setwd("C:\\\\cg2011counting\\")
  dirCommands <- paste("mkdir ", "C:\\cg2011counting\\", unique(randomHarvList$happyDirs), sep="")
  write.table(dirCommands, file="mkdirCommands.bat", sep="", row.names=FALSE, col.names=FALSE, quote=FALSE) 
  #this writes hard paths. find the .bat file and double-click it to run it.

# move files around this uses hard paths, which is ugly, but i think it's the only way
#turn letno into nolet.jpg
randomHarvList$no <- as.integer(substr(harvList$letnoHarv, 4, 7))
randomHarvList$let <- substr(harvList$letnoHarv, 1, 2) #windows is not case sensitive. no problem
randomHarvList$filename <- paste(harvList$no, harvList$let, ".jpg", sep="")
#put together the copy commands with hard paths. use subsets to do batches manually.
moveFiles <- paste("copy ", "C:\\2011_scans_sorted\\8000\\", 
      randomHarvList$filename[randomHarvList$no < 9000 & randomHarvList$no >= 8000], " C:\\\\cg2011counting\\",
      randomHarvList$happyDirs[randomHarvList$no < 9000 & randomHarvList$no >= 8000], "\\",
      randomHarvList$filename[randomHarvList$no < 9000 & randomHarvList$no >= 8000] , sep="")
setwd("C:\\\\cg2011counting\\")
write.table(moveFiles, file="moveFiles8000.bat", sep="", row.names=FALSE, col.names=FALSE, quote=FALSE) 
#again, find the batch file and double-click to run it. it's slow.