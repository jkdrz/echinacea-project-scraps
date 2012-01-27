# function dir.ea extracts information about files and returns
# the path accessed, the time accessed and a data frame,
##############

dir.ea <- function(path = ".") {
   if(path == ".") path <- getwd()
   dir <- file.info(list.files(path, full.names = FALSE, recursive = TRUE, include.dirs = FALSE))
   dir$fileName <- row.names(dir)
   dir <- dir[ , c("fileName", "size", "isdir", "mode", "mtime", "ctime")] #dropped exe for compat.
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

setwd(choose.dir())

getwd()