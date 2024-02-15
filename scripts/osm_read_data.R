
# author info -------------------------------------------------------------

# Marissa Dyck
# ACME lab
# University of Victoria
# 30 - January - 2024

# working directory -------------------------------------------------------

# set working directory to the ACME lab netdrive


setwd("/Volumes/acmelab/1.Resources/2.Arrays/Alberta/OSM/2022-2023") 
# will need to change the year for each new year of data


# libraries ---------------------------------------------------------------

# install libraries using install.packages("library name") or the Packages tab in the window pane below the environment

library(tidyverse)
library(fs)

# data --------------------------------------------------------------------

# get a list of the .csv file names from the sub-folders within the '1. Imagery/OSM_2022_LU01' folder
OSM_2022_LU01_files_3 <- list.files(
  path = '1. Imagery/OSM_2022_LU01',
  recursive = TRUE,
  pattern = "\\.*csv$",
  full.names = TRUE) %>% 

  
  # exclude files from backups sub-folders
  stringr::str_subset(.,
                      'Backups',
                      negate = TRUE) %>% 
  
  # set names and read csv files for remaining files in using purrr (map)
  {setNames(map(., read_csv), 
            sub("\\.csv$", 
                "", 
                basename(.)))}
  
  
  # use purrr to read in the remaining files with tidyverse read_csv function
  purrr::map(
    ~read_csv(.x)
  ) %>% 
  
  # set file names 
  setNames(., sub("\\.csv$", "", basename(.)))
  


# this takes a while to run bc R is looking in every sub-folder at every file to see if it matches the extension (i.e. .csv) and then saving the file name and path and then going back and removing the files from the 'backups' sub-folders. Maybe not the most elegant way to do this but beats having to copy and paste each file individually or writing a for loop.

# use readr to read in the files from the previous step
OSM_2022_LU01_data <- readr::read_csv(OSM_2022_LU01_files_2,
                                       id = 'file_name')

# check why some files have 37 columns and some have 38 columns

