library(usethis)
library(zip)


# This script makes the student workbook
project_name <- "R-course-NEON-workbook"
project_filename <- file.path("workbook", project_name)

# Remove existing files
unlink(project_filename, recursive = TRUE, force = TRUE)

# Initiate an RStudio project file
create_project(path = project_filename, open = FALSE, rstudio = TRUE)


# Make directory structure and copy data and exercises
dir.create(file.path(project_filename, "exercises"))
file.copy(from = "exercises", to = file.path(project_filename),
          recursive = TRUE)

file.copy(from = "data", to = file.path(project_filename),
          recursive = TRUE)

# Remove RStudio project files that are not needed
file.remove(file.path(project_filename, ".gitignore"))
unlink(file.path(project_filename, "R"), recursive = TRUE, force = TRUE)

# Zip the directory
zip(paste0(project_name, ".zip"), files = project_name,
    root = "workbook",
    mode = "mirror")


