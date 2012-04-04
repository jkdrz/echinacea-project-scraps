# written spring 2012 by jd. happy words list found by kt
# this script pulls data from the final harvest list (ideally it would pull from scan files)
# this will (eventually) generate a folder structure and assign letnos/filenames to that

####################################################
#todo:                                             #
#figure out filename case sensitivity issues       #
####################################################

#import harvest list, fix letnos (code from scanCompare2012.R)
harvList <- read.csv("I:\\\\Departments\\Research\\EchinaceaCG2011\\2011.CG1.Harvest.List.reconciled.csv", na.strings="")
harvList$letnoHarv <- as.character(harvList$letnoHarv) #you need to make these character vectors
harvList$letnoCorrected <- as.character(harvList$letnoCorrected)
harvList$letnoHarv[complete.cases(harvList$letnoCorrected)] <- harvList$letnoCorrected[complete.cases(harvList$letnoCorrected)]

