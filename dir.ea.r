# function dir.ea extracts information about files and returns
# the path accessed, the time accessed and a data frame,
##############

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

# Examples

getwd()
dir.ea()

path <- getwd()
dir.ea(path)

foo <- dir.ea(path)
foo$path
foo$date

dir.ea("I:/Departments/Research/Wagenius/Stuart's Reprints/Trager1998")

setwd(choose.dir()) #choose.dir is windows-specific too (and MacOS?)

getwd()

#############
# make new function that translates filename to letno

# start here...

setwd("I:\\Departments\\Research\\DiClemente\\Allegra's 2009")
aa <- dir.ea()

aa

let <- substr(aa$dir$fileName, 6, 7)
no  <- substr(aa$dir$fileName, 2, 5)
letno <- paste(let, no, sep= "-")
letno

aa$dir$letno <- letno

aa

