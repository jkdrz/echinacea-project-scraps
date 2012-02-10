# the idea is to eventually use dir.ea() to pull what's in a directory and compare
# to a vector containing the letnos or filenames that should be there.
# some finessing of filenames or letnos may be required.

#example code
(x <- c(sort(sample(1:20, 9)),NA))
(y <- c(sort(sample(3:23, 7)),NA))
setdiff(x,y) #shows values in x not found in y
setdiff(y,x) #shows values in y not found in x

#example of how you'd check on one of the computers

# x should be the filenames(converted to letno), y the letnos
# i must be doing something wrong; the first paste doesn't happen
scanCompare <-  function(x,y) {
   extraScans <- setdiff(x,y)
   notScanned <- setdiff(y,x)
#    paste("scans without associated letnos: ", extraScans)
#    paste("letnos that have yet to be scanned: ", notScanned)
list(notScanned = notScanned, extraScans = extraScans)   
   }

#test data. we'll need to finesse filenames into letnos
scannedImages <- c("AA-1000", "BB-2000", "CC-3000", "DD-4000", "FF-6000")
actualLetnos  <- c("AA-1000", "BB-2000", "CC-3000", "DD-4000", "EE-5000")
scanCompare(scannedImages, actualLetnos)




