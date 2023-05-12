# This script adds in the Chapters menu in the _site.yml file

# Read in the main text of the _site.yml file
filelines <- readLines("_site.txt")

# Read in a table defining the chapter titles
chptable <- read.delim("_chapter_names.txt")

# Order the table by chapter number
chptable <- chptable[order(chptable$chp), ]

# Identify core and supplemental chapters
corechps <- which(!is.na(as.numeric(chptable$chp)))
suppchps <- which(is.na(as.numeric(chptable$chp)))

# A function that adds a specific white space indentation to a character string
add_indent <- function(x, indent = 0){
  paste0(paste(rep(" ", indent), collapse = ""), x)
}



# A function that creates a menu item
# chp is the chapter number in the lookup table which defaults to chptable
# indent is the number of white spaces to precede the item
# type indicates whether a menu label or link should be returned
make_menu_item <- function(chp, lookup = chptable, indent = 0, type = "label"){
  
  # Define rownames of the lookup table by the chapter numbers
  rownames(lookup) <- lookup$chp
  
  # Make chp a character if not already
  chp <- as.character(chp)
  
  # Make indent
  full_indent <- paste(rep(" ", indent), collapse = "")

  switch(type,
        label = paste0(full_indent, "- text: ", chp, ". ", lookup[chp, "nameShort"]),
        link = paste0(full_indent, "  href: ", lookup[chp, "fileName"], ".html")
  )
}


# Find the line where the menu should be inserted
insert_line <- grep("chapters_menu", filelines)
indent_len <- length(gregexpr(" ", filelines[insert_line])[[1]])

# Generate the lines for the chapter menus
menu_labels <- sapply(chptable$chp[corechps], function(x) make_menu_item(x, indent = indent_len, type = "label"))
menu_links <- sapply(chptable$chp[corechps], function(x) make_menu_item(x, indent = indent_len, type = "link"))
menu_text_core <- as.vector(sapply(1:length(menu_labels), function(x) c(menu_labels[x], menu_links[x])))

menu_labels <- sapply(chptable$chp[suppchps], function(x) make_menu_item(x, indent = indent_len, type = "label"))
menu_links <- sapply(chptable$chp[suppchps], function(x) make_menu_item(x, indent = indent_len, type = "link"))
menu_text_supp <- as.vector(sapply(1:length(menu_labels), function(x) c(menu_labels[x], menu_links[x])))

# Combine with existing text
newfilelines <- c(filelines[1:(insert_line-1)],
                  add_indent("- text: '-------------'", indent = indent_len),
                  add_indent("- text: Core lessons", indent = indent_len),
                  menu_text_core,
                  add_indent("- text: '-------------'", indent = indent_len),
                  add_indent("- text: Supplemental lessons", indent = indent_len),
                  menu_text_supp,
                  filelines[(insert_line+1):length(filelines)]
)

writeLines(newfilelines, "_site.yml")

