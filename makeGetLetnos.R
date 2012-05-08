#this code comes from stuart. the file came from i:\departments\research\echinaceacg2011\
setwd("I:\\Departments\\Research\\EchinaceaCG2011")
# aa <- read.csv("I:\\Departments\\Research\\EchinaceaCG2011\\2009CgLetnos.csv", stringsAsFactor = FALSE)
# bb <- read.csv("I:\\Departments\\Research\\EchinaceaCG2011\\2010CgLetnos.csv", stringsAsFactor = FALSE)
# cc <- read.csv("I:\\Departments\\Research\\EchinaceaCG2011\\2011CgLetnos.csv", stringsAsFactor = FALSE)
aa <- read.csv("2009CgLetnos.csv", stringsAsFactor = FALSE)
bb <- read.csv("2010CgLetnos.csv", stringsAsFactor = FALSE)
cc <- read.csv("2011CgLetnos.csv", stringsAsFactor = FALSE)

# add column year
aa$year<- "2009"
bb$year<- "2010"
cc$year<- "2011"
# rbind in dd
dd<- rbind(aa,bb,cc)

# add column no
dd$no <- as.integer(substr(dd$letno, 4, 7))
dd <- dd[order(dd$no), ]

# define batch
dd$batch <- 0
dd[dd$no > 999, "batch"]  <- 1000
dd[dd$no > 1999, "batch"] <- 2000
dd[dd$no > 2999, "batch"] <- 3000
dd[dd$no > 3999, "batch"] <- 4000
dd[dd$no > 4999, "batch"] <- 5000
dd[dd$no > 5999, "batch"] <- 6000
dd[dd$no > 6999, "batch"] <- 7000
dd[dd$no > 7999, "batch"] <- 8000
dd[dd$no > 8999, "batch"] <- 9000


# write function to extract vector

getLetnos <- function(year = 2011, batch = 0) {
vv <- dd[dd$year %in% year & dd$batch %in% batch, "letno"]
ans <- data.frame(letno = vv)
fileName <- paste("letnoListCG", year, "-batch", batch, ".csv", sep= "")
write.csv(ans, file = fileName, row.names = FALSE)
invisible(ans)  
}

#getLetnos(2010, 1000) #examples
#df1 <- getLetnos(2011, 1000) #you can write it to an object

getLetnosBatches <- function(year = 2011, batch = 0) {
  ans <- dd[dd$year %in% year & dd$batch %in% batch, c("batch", "no", "letno")]
  fileName <- paste("letnoListCG", year, "-batches", ".csv", sep= "")
  write.csv(ans, file = fileName, row.names = FALSE) #this will clobber existing files
  invisible(ans)  
}

#getLetnosBatches(2011, c(1000:9000)) #examples
#x <- getLetnosBatches(2011, c(1000:3000)) #you can write it to an object



###############################################################################
# run the script up to here to get the data and functions set up.
#
###############################################################################
