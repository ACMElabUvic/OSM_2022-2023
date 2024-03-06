# ACME lab camera script
# Marissa A. Dyck
# 9-2-2024

# Install packages ----------------------

# if you don't have the following packages use the code below to install them

install.packages('tidyverse') # data import, manipulation, visualization
install.packages("withr") # temporarily change working directory


# Libraries ----------------------

# then load the libraries for this R session

library(tidyverse) # will load all tidyverse packages, can see complete list using tidyverse_packages()
library(withr)


# Timelapse data ----------------------------------------------------------

# Import timelapse files option 1 ----------------------------------------------

# option one: read all files in and join them in the same step using map_dfr (map is a purrr function that performs iterations and map_dfr returns data frames by row-binding objects together)

# temporarily set the working directory to import from the NetDrive

with_dir(new = '/Volumes/acmelab/1.Resources/2.Arrays/Alberta/OSM/2022-2023',
         
         # make a list of all .csv files in the 2. Timelapse Files folder
         OSM_2022_data <- list.files(
           path = '2. Timelapse Files', # provide the folder/s within the working drive where the files are stored
           pattern = '*\\.csv*', # provide the extension in case there are other files saved in that folder you don't want to load
           full.names = TRUE) %>% 
           
           map_dfr(~.x %>% 
                     read_csv(.,
                              
                              # specify how to read in the various columns, if you don't specify this R reads some of the columns in differently for different files and the code won't work to join them. (Still looking for a more efficient way to do this rather than one-by-one but for now this works)
                              col_types = cols(RootFolder = col_character(),
                                               File = col_character(),
                                               RelativePath = col_character(),
                                               Dark = col_logical(),
                                               DeleteFlag = col_logical(),
                                               Site = col_factor(),
                                               Classifier = col_factor(),
                                               Snow = col_factor(),
                                               Species = col_factor(),
                                               Event = col_character(),
                                               Empty = col_logical(),
                                               CoatColour = col_character(),
                                               CameraMalfunction = col_factor(),
                                               OtherSpecify = col_character(),
                                               Comments = col_character(),
                                               Noteworthy = col_logical(),
                                               DateTime = col_datetime(format = "%Y-%m-%d %H:%M:%S"),
                                               .default = col_integer()))) %>%  #.default sets any unspecified columns to this type
           
           # set the column names to lowercase, this makes it easier to avoid case-sensitive mistakes when coding
           set_names(
             names(.) %>%  
               tolower()))

# finished importing data, this code will return warnings related to 'parsing issues'. Don't panic it is fine.



# Import timelapse files option 2 ------------------------------------------------------

# option two: read files in as a list and keep them separated by landscape unit (LU). This is useful if you want to do something with the separate files, but otherwise option one is probably better

# make a list of all .csv files in the 2. Timelapse Files folder
OSM_2022_data_files <- list.files(
  path = '2. Timelapse Files', # provide the folder/s within the working drive where the files are stored
  pattern = '*\\.csv*', # provide the extension in case there are other files saved in that folder you don't want to load
  full.names = TRUE) %>% 
  
  # set the names to the base name of each file w/o the .csv file extension and read in all the files using read_csv 
  {setNames(map(., read_csv), sub("\\.csv$", "", basename(.)))}


# Data checks timelapse -------------------------------------------------------------

# check the internal structure
str(OSM_2022_data) # this should all be good since we specified how to read in each variable above, but if new columns are added from the timelapse process, may need to double check this


# check that all the sites are accounted for
# for 2022-2023 data there should be 155 (there were 56 sites originally but LU01-31 had no data)
levels(OSM_2022_data$site) 

# need to fix entry LU 01-71 to LU01-71 (has unnecessary space)
# also all the other data frames use '_' not '-' for the site names so we should change this in the timelapse data

# check that all the species names were entered correctly
levels(OSM_2022_data$species)

# no glaring issues with species entries


# check for NAs in columns that shouldn't have NAs, looking at the summary is also a good way to check for other issues with the data
summary(OSM_2022_data)

# there is 1 NA in the site column, let's check what other data is associated with this entry
OSM_2022_data %>% 
  
  filter(is.na(site))
# it is not an entry with an animal so I wouldn't worry about fixing the site entry



# Data manipulation timelapse -------------------------------------------------

# can add code/remove code within the code chunk below to fix any issues that were found from the data check steps each year

# first make sure to assign an object to the environment that will be your new fixed data. I usually start with a new object (e.g. OSM_2022_data_fixed) as I fiddle with the code to make sure it works and then replace this with the original data name (e.g. OSM_2022_data) and just overwrite the data since I don't want the version with all the issues anyways.
OSM_2022_data_fixed <- OSM_2022_data %>% 
  
  # removed extra columns (see R markdown for info on why these columns got added)
  select(!c(...37,
            dark,
            ...38)) %>% 
  
  # fix issues with site column 
  mutate(
    # fix site entry with unnecessary space
    site = recode(site,
                  # old entry followed by new entry
                  'LU 01-71' = 'LU01-71'), 
    
    # change format of sites to include '_' instead of '-'
    site = str_replace(site,
                       pattern = '\\-',
                       replacement = '_'),
    
    # site needs to be a factor and for some reason the code above changes it to a character
    site = as.factor(site)) 


# use code below  to check that each step worked

# columns (removed extra columns w/ NAs)
names(OSM_2022_data_fixed)
 
# sites (fixed LU 01-71)
levels(OSM_2022_data_fixed$site)


# Save clean full timelapse data if someone needs this data later
write_csv(OSM_2022_data_fixed,
          'data/processed/OSM_2022_timelapse.csv')




# Independent detections --------------------------------------------------

# we will continue working with the OSM_2022_data but you could start here and import the data again if needed but you'd have to change the structure of a couple variables that get re-read in wrong after the export and import process. Can uncomment and use the code below to do that.

# can select code chunk and use command + shift + c to uncomment or comment a large portion of code

# OSM_2022_data_fixed <- read_csv('data/processed/OSM_2022_timelapse.csv')
# 
# # ignoring parsing issues warning, this is just referring to some columns it's expecting logical data for and they contain characters.
# 
# # check internal structure, even though we specified everything above with the fixed data when we export and import R often reads the variables in wrong again
# str(OSM_2022_data_fixed) 
# 
# # datatime read correctly but we will need to change site and species to factors again
# 
# OSM_2022_data_fixed <- OSM_2022_data_fixed %>% 
#   
#   mutate(species = as.factor(species),
#          site = as.factor(site))


# prep the data for calculating independent detections
OSM_2022_det <- OSM_2022_data_fixed %>% 
  
  # select only variables of interest
  select(site,
         species,
         datetime) %>% 
  
  # remove rows with no species info
  drop_na(species) %>% 
  
  # now we need to create a new variable called timediff
  # first make sure data are arrange in proper order
  arrange(site, species, datetime) %>% # this will NOT work if not in correct order (early-late date)
  
  # create groups for each species at each site
  group_by(species, site) %>%
  
  # create new variable timediff that will calculate the difference 
  mutate(timediff = as.numeric(difftime(datetime,lag(datetime),
                                        units = "mins")))


# set the independent detection threshold to 30 minutes
mins <- 30 

# loop that assigns group ID (this is not my code don't at me if it doesn't work :/)
# identifies when there are photos/rows that are more than 30 mins apart
# Attributes an event ID
OSM_2022_det$event_id <- 9999
seq <- as.numeric(paste0(nrow(OSM_2022_det),0))
seq <- round(seq,-(nchar(seq)))

for (i in 2:nrow(OSM_2022_det)) {
  OSM_2022_det$event_id[i-1]  <- paste0("E",format(seq, scientific = F))
  if(is.na(OSM_2022_det$timediff[i]) | abs(OSM_2022_det$timediff[i]) > (mins)){
    seq <- seq + 1
  }
}

if(OSM_2022_det$timediff[nrow(OSM_2022_det)] < (mins)|
   is.na(OSM_2022_det$timediff[nrow(OSM_2022_det)])){
  OSM_2022_det$event_id[nrow(OSM_2022_det)] <- OSM_2022_det$event_id[nrow(OSM_2022_det)-1]
} else{OSM_2022_det$event_id[nrow(OSM_2022_det)] <- paste0("E",format(seq+1, scientific = F))
}

# now create a new data frame with a single row for each event
OSM_2022_det_indv <- OSM_2022_det %>% 
  group_by(event_id) %>%
  filter(row_number()==1)

# now we are left with a data frame that has 14,102 individual detections
OSM_2022_det_indv

# let's also save this data to the processed folder for later use

write_csv(OSM_2022_det_indv,
          'data/processed/OSM_2022_indv_det.csv')


# Graph independent detections --------------------------------------------

# read in saved detection data if starting here
OSM_2022_det_indv <- read_csv('data/processed/OSM_2022_indv_det.csv') %>% 
  
  # change site, species and event_id to factor
  mutate_if(is.character,
            as.factor)


# check number of different species
levels(OSM_2022_det_indv$species)

# create a vector of the list of mammals to use for quick data visualization/exploration. Could also create a list of species that aren't useful if that is shorter and use filter(!species %in% OBJECTNAME) but for this example the vectors were about the same length
mammals <- c('White-tailed deer',
             'Black bear',
             'Snowshoe hare',
             'Moose',
             'Coyote',
             'Fisher',
             'Red squirrel',
             'Striped skunk',
             'Grey wolf',
             'Red fox',
             'Cougar',
             'Lynx',
             'Short-tailed weasel',
             'Porcupine',
             'Beaver',
             'Martin',
             'Wolverine',
             'Caribou',
             'Long-tailed weasel')

# remove NAs and select just images with mammals first then pipe new data into ggplot
det_graph <- OSM_2022_det_indv %>% 
  
  # remove less useful species
  filter(species %in% mammals) %>% 
  
  # get the number of individual detections per species to add to graph
  group_by(species) %>% 
  
  mutate(n = n()) %>% 
  
  ungroup() %>% 
  
  ggplot(.,
         aes(x = species)) +
  
  # create bar graph of the counts of each spp in the data
  geom_bar(aes(fill = species)) +
  
  # add the number of detections above each bar using the variable n we calculated earlier
  geom_text(aes(label = n,
                y = n + 50),
            size = 4) +
  
  # change y axis label
  labs(y = 'Number of independent detections') +
  
  # change breaks for y axis
  scale_y_continuous(breaks = seq(0,3500, by = 250)) +
  
  # change theme elements
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust = 1,
                                   size = 14),
        axis.title = element_text(size = 16),
        axis.ticks.x = element_blank(),
        panel.grid = element_blank()) 

# print graph
det_graph


# save graph as jpeg (can also save as tiff, png, pdf by changing the file extension)
ggsave('2022_indv_det_graph.jpeg',
       det_graph,
       path = 'outputs',
       width = 12,
       height = 10,
       units = 'in',
       dpi = 600)




# Covariate data ----------------------------------------------------------

# Import covariates ----------------------------------------------------------

# these data files have a similar format so we will read them in together using the map() function in the purrr package

covariate_data <-    
  # provide file path (e.g. folders to find the data)
  file.path('data/raw',
            
            # provide the file names
            c('OSM_LU01_LU13_LU15_LU21_HFI_2022.csv',
              'OSM_LU01_LU13_LU15_LU21_VEG_2022.csv')) %>%
  
  # use purrr map to read in files, the ~.x is a placeholder that refers to the object before the last pipe (aka the list of data we are reading in) so all functions inside the map() after ~.x will be performed on all the objects in the list we provided
  map(~.x %>%
        read_csv(.,
                 
                 # specify how to read in the various columns
                 col_types = cols(Site = col_factor(),
                                  BUFF_DIST = col_integer(),
                                  .default = col_number())) %>%
        
        
        
        # set the column names to lower case
        set_names(
          names(.) %>% 
            tolower() %>% 
            
            # remove the FEATURE_TY in front of all the column names
            str_remove(pattern = "feature_ty") %>% 
            
            # replace the '.' with '_'
            str_replace_all(pattern = '\\.', # provide the character pattern to look for (if you don't keep the \\ it won't work)
                            replacement = '_'))) %>%  # what you want the pattern to be replaced with
  
  # set the names of the two files in the list, if you don't run this they will be named numerically (e.g. [1], [2]) which can get confusing
  purrr::set_names('HFI',
                   'VEG')

# will get a warning about parsing issues, don't panic it is fine



# Data check covariates ---------------------------------------------------

# internal structure
covariate_data %>% 
  
  # apply str() function inside map()
  map(~.x %>% 
        str(.))

# check that the sites are all there and entered correctly, there should be 155

# since the data sets are in a list we need to call the list first, then the data name in the list, then the column name
levels(covariate_data$HFI$site)
levels(covariate_data$VEG$site)

# there are 155 for both and don't see any glaring issues but let's check that all these site names match each other using the setdiff function
setdiff(levels(covariate_data$VEG$site),
        levels(covariate_data$HFI$site))

# no mismatches

# we need to check that they also match the osm_2022_Det
setdiff(levels(OSM_2022_det_indv$site),
        levels(covariate_data$HFI$site))

# [1] "LU12_51" "LU15_35"
# there seems to be two site names that are different between the covariate data sets and the detection data

# reverse the order to see which two are extras in the covariate data
setdiff(levels(covariate_data$HFI$site),
        levels(OSM_2022_det_indv$site))

# [1] "LU13_51" "LU13_35" it looks like the landscape units might have gotten typed in wrong. # checked with original data and these are the correct ones 

# WE ARE GOING TO FIX THE ORIGINAL CSV FILES FROM TIMELPASE SO CAN IGNORE THESE COMMENTS IF RE-RUNNING THIS CODE



# Join covariates ---------------------------------------------------------

covariates_all <- covariate_data$HFI %>% 
  
  #use full join in case any issues with missing observations but we should be good since we checked the site names
  full_join(covariate_data$VEG,
            by = c('site', 'buff_dist'))


# there are quite a few sites for which there isn't any data???



# Deployment data ---------------------------------------------------------


# Import deployment --------------------------------------------

# read in data files individually 

# deployment data
deploy <- read_csv('data/raw/OSM_2022_Deployment_Data.csv',
                   
                   # specify how we want the columns read in 
                   col_types = cols(Project.ID = col_factor(),
                                    Deployment.Location.ID = col_factor(),
                                    Camera.Deployment.Begin.Date. = col_date(
                                      format = "%d-%b-%y"),
                                    Camera.Deployment.End.Date = col_date(
                                      format = "%d-%b-%y"),
                                    .default = col_character())) %>% 
                   # the date columns could be read in as such if we needed but I don't think we use them and the date format is odd to get R to read
  
  # set the column names to lower case and replace the '.' with '_' (these are both personal preferences of mine)
  set_names(
    names(.) %>% 
      tolower() %>% 
      
      # replace the '.' with '_'
      str_replace_all(pattern = '\\.', # provide the character pattern to look for (if you don't keep the \\ it won't work)
                      replacement = '_')) %>%  # what you want the pattern to be replaced with
  
  # rename start and end date so they are shorter
  rename(.,
         start_date = camera_deployment_begin_date_,
         end_date = camera_deployment_end_date)
  
  

# deployment site data
cameras <- read_csv('data/raw/OSM_2022_Deployment_Site_Data.csv',
                    
                    # specify how we want the columns read in 
                    col_types = cols('Deploy Date' = col_date(
                      format = "%d-%b-%y"),
                      'Deploy Time' = col_time(),
                      Lat = col_number(),
                      Long = col_number(),
                      Grade = col_integer(),
                      Elevation = col_integer(),
                      'Distance to trail (m)' = col_number(),
                      'Distance to Lure' = col_number(),
                      'Comments and Access Notes' = col_character(),
                      .default = col_factor()
                    )) %>% 
  
  # set the column names to lower case and replace the spaces with '_' (these are both personal preferences of mine)
  set_names(
    names(.) %>% 
      tolower()%>% 
      str_replace_all(pattern = ' ',
                      replacement = '_'))

# not sure if we need this data, may remove this section later if not needed.


# Data check deployment -------------------------------------------------------------

# make sure the columns read in properly

str(deploy)
# everything looks good

# let's check the levels for the landscape units (project_id) and the sites (deployment_location_id) to make sure they match the other data

# landscape unit
levels(deploy$project_id)

# site
levels(deploy$deployment_location_id)

# since the timelapse data should be correct (fingers crossed) let's put it second and see if there are different sites in the deployment data
setdiff(levels(deploy$deployment_location_id),
        levels(OSM_2022_det_indv$site))

# [1] "LU15-44" "LI15_03"
# there are two sites different and just by looking at these I can see the issue. LU15-44 should be LU15_44 and LI15_03 should be LU15_03. We can fix these in the data manipulation section below




# Data manipulation deployment --------------------------------------------

deploy_fixed <- deploy %>% 
  
  # rename site entries
  mutate(deployment_location_id = as.factor(case_when(deployment_location_id == 'LU15-44' 
                                            ~ 'LU15_44',
                                            deployment_location_id == 'LI15_03' 
                                            ~ 'LU15_03',
                                            TRUE 
                                            ~ deployment_location_id)))


# check to see that the above code worked
setdiff(levels(deploy_fixed$deployment_location_id),
        levels(OSM_2022_det_indv$site))

# now they match

# remove old version of data
rm(deploy)


