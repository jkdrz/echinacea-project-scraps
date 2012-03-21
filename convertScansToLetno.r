#this file contains code to convert scan filenames to letnos
#use dir.ea() to 


#2009

let <- substr(aa$dir$fileName, 6, 7)
no  <- substr(aa$dir$fileName, 2, 5)
letno <- paste(let, no, sep= "-")
letno