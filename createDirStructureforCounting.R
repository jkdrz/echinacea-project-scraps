# written spring 2012 by jd. happy words list found by kt
# this script pulls data from the final harvest list (ideally it would pull from scan files)
# this will (eventually) generate a folder structure and assign letnos/filenames to that
# don't run the entire script at once, you might clobber important files.

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

harvList$let <- substr(harvList$letnoHarv, 1, 2)
harvList$no <- as.integer(substr(harvList$letnoHarv, 4, 7))
harvList$filename <- paste(harvList$no, harvList$let, ".jpg", sep="")#turn letno into nolet.jpg

###############################################################################
#
# 8000 batch
#
###############################################################################
batch    <- 8000
inb1and2 <- harvList$no < (batch+1000) & harvList$no >= batch
h8000 <- harvList[inb1and2, ]

#we'll add a few dummy directories, just in case. pull out 490 entries
happyList <- sample(happy$lowercase, 230, replace=FALSE)
happyDirs <- rep(happyList, each=6)

# put together the vectors, keeping lets and nos, so i can actually write out files in batches

h8000 <- h8000[sample(1: dim(h8000)[1]), ] #sample the dataframe. sample(h8000) won't work
happyDirs8000 <- happyDirs[1:230]
randomHarvList8000 <- data.frame(h8000, happyDirs8000)
leftoverHappyDirs <- happyDirs[(length(randomHarvList8000$letnoHarv)+1):length(happyDirs)]

#write out some useful files
write.csv(randomHarvList8000, file="C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/2011.CG1.HarvList8000.csv")
write.csv(leftoverHappyDirs, file="C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/2011.CG1.LeftoverHappyDirs.csv")

# create directory structure. only run this this first time.
  setwd("C:\\\\cg2011counting\\")
  dirCommands <- paste("mkdir ", "C:\\cg2011counting\\", unique(randomHarvList8000$happyDirs8000), sep="")
  write.table(dirCommands, file="mkdirCommands.bat", sep="", row.names=FALSE, col.names=FALSE, quote=FALSE) 
  #this writes hard paths. find the .bat file and double-click it to run it.

# move files around this uses hard paths, which is ugly, but i think it's the only way

#put together the copy commands with hard paths. use subsets to do batches manually.
moveFiles <- paste("copy ", "C:\\2011_scans_sorted\\8000\\", 
      randomHarvList8000$filename[randomHarvList8000$no < 9000 & randomHarvList8000$no >= 8000], " C:\\\\cg2011counting\\",
      randomHarvList8000$happyDirs[randomHarvList8000$no < 9000 & randomHarvList8000$no >= 8000], "\\",
      randomHarvList8000$filename[randomHarvList8000$no < 9000 & randomHarvList8000$no >= 8000] , sep="")
setwd("C:\\\\cg2011counting\\")
write.table(moveFiles, file="moveFiles8000.bat", sep="", row.names=FALSE, col.names=FALSE, quote=FALSE) 
#again, find the batch file and double-click to run it. it's slow.

###############################################################################
#
# 4000 batch
#
###############################################################################
#read in the old happy words list
happy <- read.csv("C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/2011.CG1.LeftoverHappyDirs.csv")
happy <- happy$x[5:length(happy$x)] #tiny was already used, so drop the first 4 
happyDirs <- as.character(happy)

inb1and2 <- harvList$no < 5000 & harvList$no >= 4000
h4000 <- harvList[inb1and2, ]


# put together the vectors, keeping lets and nos, so i can actually write out files in batches

h4000 <- h4000[sample(1: dim(h4000)[1]), ] #sample the dataframe. sample(h8000) won't work
happyDirs4000 <- happyDirs[1:520]
randomHarvList4000 <- data.frame(h4000, happyDirs4000)
leftoverHappyDirs <- happyDirs[(length(randomHarvList4000$letnoHarv)+1):length(happyDirs)]

#write out some useful files
write.csv(randomHarvList4000, file="C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/2011.CG1.HarvList4000.csv")
write.csv(leftoverHappyDirs, file="C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/2011.CG1.LeftoverHappyDirs-40008000.csv")

# create directory structure. only run this this first time.
setwd("C:\\\\pelican\\")
dirCommands <- paste("mkdir ", "C:\\pelican\\", unique(randomHarvList4000$happyDirs4000), sep="")
write.table(dirCommands, file="mkdirCommands.bat", sep="", row.names=FALSE, col.names=FALSE, quote=FALSE) 
#this writes hard paths. find the .bat file and double-click it to run it.

# move files around this uses hard paths, which is ugly, but i think it's the only way
#put together the copy commands with hard paths. use subsets to do batches manually.
moveFiles <- paste("copy ", "C:\\2011_scans_sorted\\4000\\", 
                   randomHarvList4000$filename[randomHarvList4000$no < 5000 & randomHarvList4000$no >= 4000], " C:\\\\pelican\\",
                   randomHarvList4000$happyDirs[randomHarvList4000$no < 5000 & randomHarvList4000$no >= 4000], "\\",
                   randomHarvList4000$filename[randomHarvList4000$no < 5000 & randomHarvList4000$no >= 4000] , sep="")
write.table(moveFiles, file="moveFiles4000.bat", sep="", row.names=FALSE, col.names=FALSE, quote=FALSE) 
#again, find the batch file and double-click to run it. it's slow.
dirSort <- rep(sample(1:87),each=6)[1:520]
forDataSheet <- cbind(as.character(randomHarvList4000$filename), as.character(randomHarvList4000$happyDirs4000),dirSort)
write.csv(forDataSheet,"C:/Documents and Settings/jdrizin/My Documents/Dropbox/CGData/165_count/count2011/count2011_work/4000list.csv")