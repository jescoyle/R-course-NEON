## Put any code to be evaluated before any lesson here.


# Set the web address where R will look for files from this repository
# NOT WORKING YET BECAUSE REPO IS PRIVATE
#repo_url <- "https://raw.githubusercontent.com/jescoyle/R-course-NEON/master/"



# A function that prints the learning objectives for a chapter
# chp = an integer
# lookup = dataframe with objectives
# prefix = whether to append prefix to the beginning
get_LO<- function(chp, lookup, prefix = FALSE, bullet = "-"){
  
  # order table by chapter and objective number to preserve consistency
  lookup <- lookup[with(lookup, order(chp, objNum)), ]
  
  # filter rows that pertain to this chapter
  objs <- lookup[lookup$chp == chp, "text"]
  
  # format as a markdown list
  objs_list <- paste(paste(bullet, objs, sep = " "), collapse = "\n")
  
  # prepend prefix if all the same
  if(prefix){
  
    pretext <- lookup[lookup$chp == chp, "prefixText"]
    
    if(length(unique(pretext)) == 1){
      objs_list <- paste0(unique(pretext), ": \n\n", objs_list)
    } else {
     
      # remake list and prepend a blank with a colon
      objs_list <- paste(paste(bullet, paste(pretext, objs), sep = " "), collapse = "\n") 
      objs_list <- paste0(": \n\n", objs_list)
    }
  }
  
  # return text
  # NOTE: may need to remove quotes before returning
  objs_list
}

LOtable <- read.delim("_learning_objectives.txt")
CStable <- read.delim("_computing_skills.txt")

# A function that looks up the name of a chapter based on its number 
# chp is a string
# lookup is the table matching numbers to names
# type.to is the column in the table corresponding to the type of name desired
#   (e.g. "fileName", "nameShort", "nameLong"
# type.from is the column in the table corresponding to the type of name given to the function
#   (e.g. "chp" or "fileName")
get_chpName <- function(chp, lookup = chptable, type.to = "nameLong", type.from = "chp"){
  
  # Assign row names based on the chapter numbers column
  rownames(lookup) <- lookup[, type.from]
  
  # Convert chp to string if not already
  chp <- as.character(chp)
  
  # Select the column with the name type desired for the rows given in chp
  lookup[chp, type.to]
  
}

# A function that looks up the number of a chapter based on its name
# name is the string containing the name of the chapter
# lookup is the table matching chaprer numbers to names
# type is the column in the table corresponding to the type of name given
#   (e.g. "fileName", "nameShort", "nameLong"
get_chpNum <- function(name, lookup = chptable, type = "fileName"){
  
  # Assign row names based on the chapter names column
  rownames(lookup) <- lookup[, type]
  
  # Select the chp numbers column with the names given
  lookup[name, "chp"]
}

chptable <- read.delim("_chapter_names.txt")
