# this script will pull the filenames from directories and compare them against the 
# 2011 harvest list. some of the paths are hard-coded and some are not.
# written 16 Mar 2012, first draft by josh, dir.ea from stuart's code 
# (eventually it'll be part of an echinacea project library)

#paths
setwd(choose.dir()) # choose the thousands
#setwd("C:\\\\2011_scans_sorted\\3000")

# path to harvest list: set na.strings since not every blank was being picked up as NA
harvList <- read.csv("I:\\\\Departments\\Research\\EchinaceaCG2011\\2011.CG1.Harvest.List.reconciled.csv", na.strings="")

#declare the dir.ea() function
dir.ea <- function(path = ".") {
  if(path == ".") path <- getwd()
  dir <- file.info(list.files(path, full.names = FALSE, recursive = TRUE, include.dirs = FALSE))
  dir$fileName <- row.names(dir)
  dir <- dir[ , c("fileName", "size", "isdir", "mode", "mtime", "ctime", "atime")] #dropped exe for compat.
  row.names(dir) <- NULL
  date <- Sys.time()
  ans <- list(dir = dir,
              path = path,
              date = date
              )
  name <- paste(dirname(path), "/", basename(path), "/", "dir-", basename(path), "-", format(date, "%Y-%b-%d"), ".csv", sep = "")
  ans
}

# fix the letnos from the harvest list, as the format is strange: one column has NAs for non-changes
harvList$letnoHarv <- as.character(harvList$letnoHarv) #you need to make these character vectors
harvList$letnoCorrected <- as.character(harvList$letnoCorrected)
harvList$letnoHarv[complete.cases(harvList$letnoCorrected)] <- harvList$letnoCorrected[complete.cases(harvList$letnoCorrected)]
harvList$no <- as.integer(substr(harvList$letnoHarv, 4, 7))

##############################################################
# start here for subsequent runs of the script
# grab the directory information
scans <- dir.ea()
let <- toupper(substr(scans$dir$fileName, 5, 6)) #make things uppercase, since harvList uses uppercase
no  <- substr(scans$dir$fileName, 1, 4)
letno <- paste(let, no, sep= "-") # SCANNED FILENAMES

#put the issues into vectors. make sure to adjust the numbers in the first missingScans line
extraScans   <- setdiff(letno, harvList$letnoHarv) #scanned files with filename errors
missingScans <- setdiff(harvList$letnoHarv[harvList$no < 4000 & harvList$no >= 3000], letno) #letnos without scans
missingScans <- na.omit(missingScans) #for some reason, the previous command makes NAs. omit them
missingScansdf <- harvList[harvList$letnoHarv %in% missingScans,]


#information
# it may be nice to turn these into dataframes, especially the missingScans bit.
cat("the following letnos / filenames are not in the harvest list:", extraScans, "\ncheck the image for the correct letno")

#some code to bind together multiple issues. you'll want to run these each time
#first run: # extraScansFull <- extraScans
extraScansFull <- c(extraScans, extraScansFull)

#first run: # missingScansFull <- missingScansdf
missingScansFull <- rbind(missingScansFull, missingScansdf)

#cut out columns and write out CSVs for turning into FIXME datasheets
missingScansFull <- subset(missingScansFull, select=-c(cgheadid,nmmp,emmr,linePaper,garden,S.1,S.1,
                                                       S.2,S.3,S.4,letnoCorrected,Row,Pos,tt,
                                                       gBagHarv,S.5,harvnoteCorrected,S.6,Block,X,
                                                       cgheadid.1,gBagHarv.1,S.5.1,harvnoteHarv.1,
                                                       S.6.1,Block.1)) #i should remove NH
write.csv(missingScansFull, file="..\\missingScansDatasheet.csv") #this writes to the directory above
write.csv(extraScansFull, file="..\\extraScansDatasheet.csv")