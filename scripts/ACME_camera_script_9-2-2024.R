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
    site = as.factor(site),
    
    # add month and year columns from the datetime data for merging with other files later
    month = month(datetime),
    year = year(datetime)
    ) 


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
         datetime,
         month,
         year) %>% 
  
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
OSM_2022_det_ind <- OSM_2022_det %>% 
  group_by(event_id) %>%
  filter(row_number()==1)

# now we are left with a data frame that has 14,102 individual detections
OSM_2022_det_ind

# let's also save this data to the processed folder for later use

write_csv(OSM_2022_det_ind,
          'data/processed/OSM_2022_ind_det.csv')


# Graph independent detections --------------------------------------------

# read in saved detection data if starting here
detections <- read_csv('data/processed/OSM_2022_ind_det.csv') %>% 
  
  # change site, species and event_id to factor
  mutate_if(is.character,
            as.factor)


# check number of different species
levels(detections$species)

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
det_graph <- detections %>% 
  
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
       path = 'figures',
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
setdiff(levels(OSM_2022_det_ind$site),
        levels(covariate_data$HFI$site))

# [1] "LU12_51" "LU15_35"
# there seems to be two site names that are different between the covariate data sets and the detection data

# reverse the order to see which two are extras in the covariate data
setdiff(levels(covariate_data$HFI$site),
        levels(OSM_2022_det_ind$site))

# [1] "LU13_51" "LU13_35" it looks like the landscape units might have gotten typed in wrong. # checked with original data and these are the correct ones 

# WE ARE GOING TO FIX THE ORIGINAL CSV FILES FROM TIMELPASE SO CAN IGNORE THESE COMMENTS IF RE-RUNNING THIS CODE



# Join covariates and format ---------------------------------------------------------

covariates_all <- covariate_data$HFI %>% 
  
  #use full join in case any issues with missing observations but we should be good since we checked the site names
  full_join(covariate_data$VEG,
            by = c('site', 'buff_dist'))


# there are quite a few sites for which there isn't any data???


# save joined data 
write_csv(covariates_all,
          'data/processed/OSM_2022_covariates.csv')


# we also may want to pivot wider so that each column is for a different buffer for modeling purposes, we can use pivot wider to do this

covariates_all_wide <- covariates_all %>% 
  
  pivot_wider(.,
              names_from = buff_dist,
              values_from = c(harvest_area:lc_class230))


# save wide format data 
write_csv(covariates_all_wide,
          'data/processed/OSM_2022_WIDE_covariates.csv')

# Deployment data ---------------------------------------------------------


# Import deployment --------------------------------------------

# read in deployment data and camera data files individually

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
                      replacement = '_'))  # what you want the pattern to be replaced with
  
  

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
        levels(OSM_2022_det_ind$site))

# [1] "LU15-44" "LI15_03"
# there are two sites different and just by looking at these I can see the issue. LU15-44 should be LU15_44 and LI15_03 should be LU15_03. We can fix these in the data manipulation section below




# Data manipulation deployment --------------------------------------------

deploy_fixed <- deploy %>% 
  
  # rename start and end date so they are shorter
  # rename project_id and deployment_location_id so they match previous years' columns
  rename(start_date = camera_deployment_begin_date_,
         end_date = camera_deployment_end_date,
         array = project_id,
         site = deployment_location_id) %>% 
  
  # rename site entries and remove prefix OSM from array
  mutate(site = as.factor(case_when(site == 'LU15-44' 
                                    ~ 'LU15_44',
                                    site == 'LI15_03' 
                                    ~ 'LU15_03',
                                    TRUE 
                                    ~ site)),
         array = str_remove(array, 
                            pattern = "OSM_")) %>% 
  
  # remove columns we don't need
  select(!c(camera_failure_details,
            deployment_id))


# check to see that the above code worked for renaming sites
setdiff(levels(deploy_fixed$site),
        levels(OSM_2022_det_ind$site))

# now they match

# save to processed data folder

write_csv(deploy_fixed,
          'data/processed/OSM_2022_deployment.csv')



# Camera operability ------------------------------------------------------

# if starting from this point read in data
deploy_fixed <- read_csv('data/processed/OSM_2022_deployment.csv')

# create graph of camera operability

ggplot(deploy_fixed, aes(color = array))+
  
  geom_segment(aes(x = start_date, 
                   xend = end_date,
                   y = site, 
                   yend = site)) +
  
  theme(axis.text = element_text(size = 6))


# something weird is happening with a site in LU15, it has a later end date than the others by a lot. Let's plot just LU15 so we can see which site it is, it is probably a typo in the deployment data we will need to fix in the raw file.

deploy_fixed %>% 
  
  filter(array == 'LU15') %>% 
  
 ggplot(., ) +
  
  geom_segment(aes(x = start_date,
                   xend = end_date,
                   y = site, 
                   yend = site))

# the site we need to check in the raw data is LU15_12

# Response metrics --------------------------------------------------------

# there are several response metrics we can calculate, the ones we will cover here are 

# 1. Total independent detections per species/site
# 2. Presence/absence per species/site
# 3. Proportion of monthly detections



# Data --------------------------------------------------------------------


# for this we need the deployment and independent detection data we created earlier, if you are still working through this script its the 'deploy_fixed' & 'detections' objects

# or you can read them in here

# deploy
deploy_fixed <- read_csv('data/processed/OSM_2022_deployment.csv')


# detections
detections <- read_csv('data/processed/OSM_2022_ind_det.csv') %>% 
  
  # change site, species and event_id to factor
  mutate_if(is.character,
            as.factor)


# create a list of focal species for filtering the data/plots
 focal_species <- c('Black bear',
                    'Caribou',
                    'Cougar',
                    'Coyote',
                    'Fisher',
                    'Grey wolf',
                    'Lynx',
                    'Moose',
                    'Red fox',
                    'White-tailed deer',
                    'Wolverine')

# 1. Total independent detections  ----------------------------------------

total_detections <- detections %>% 
  
  # group by site and species to count detections
  group_by(site, species) %>% 
  
  # use summarise to count detections per species per site
  summarise(detections = n()) %>% 
  
  ungroup() %>% 
  
  pivot_wider(names_from = species,
              values_from = detections) %>% 
  
  # replace NAs with 0 in all species columns
  mutate(across(
    where(is.numeric),
    ~ replace_na(., 0)))
  
  
# save csv file to processed data folder as OSM_2022_total_detections
write_csv(total_detections,
          'data/processed/OSM_2022_total_detections.csv')


# now lets make a plot of total detections

site_detections_plot <-  total_detections %>% 
  
  # we need to pivot longer to create species column again for plotting
  pivot_longer(cols = 2:40,
               names_to = 'species',
               values_to = 'detections') %>% 
  
  # remove less useful species using a list created in the 'Graph independent detections' section
  filter(species %in% focal_species) %>% 
  
  # pipe into ggplot function
ggplot(.,
       aes(x = site,
           y = detections)) +
  
  geom_col() +
  
  # use facet wrap to make separate plots for each species 
  facet_wrap(vars(species)) +
  
  # shift axis text to 90 degrees so site name are readable
  theme(axis.text.x = element_text(angle = 90,
                                   size = 3),
        axis.ticks.x = element_blank())


# view plot
site_detections_plot

# not the most readable plot because some species are skewing the x axis really high but it works for exploratory purposes

# save graph as jpeg (can also save as tiff, png, pdf by changing the file extension)
ggsave('2022_detections_by_site.jpeg',
       site_detections_plot,
       path = 'figures',
       width = 12,
       height = 10,
       units = 'in',
       dpi = 600)



# 2. Presence/absences ----------------------------------------------------


total_detections <- read_csv('data/processed/OSM_2022_total_detections.csv')

# we can use the data from above to create a similar response metric of simply presences and absences per species per site

species_presence <- total_detections %>% 
  
  # replace all values above 0 with 1s
  mutate_if(is.numeric, 
            ~1 * (. > 0))

# now we have presence absence data for all species


# save data to data/processed folder
write_csv(species_presence,
          'data/processed/OSM_2022_species_presence.csv')



# plot this data in ggplot
species_presence_plot <- species_presence %>% 
  
  # first we need to pivot the data longer again so we have a species column for plotting
  pivot_longer(cols = 2:40,
               names_to = 'species',
               values_to = 'presence') %>% 
  
  # remove less useful species using a list created in the 'Graph independent detections' section
  filter(species %in% focal_species) %>% 
  
  # pipe into ggplot function
ggplot(., 
       aes(x = site, y = presence)) +
  
  # use geom_jitter instead of geom_point so we can shift points on y-axis to make them easier to view
  geom_jitter(shape = 16,
              size = 1.5,
              width = 0,
              height = 0.05,
              alpha = 0.5) +
  
  # use facet_wrap to make separate plots for each species so data is easier to look at
  facet_wrap(vars(species)) +
  
  # shift axis text to 90 degrees so site name are readable
  theme(axis.text.x = element_text(angle = 90,
                                   size = 3))



# view plot
species_presence_plot

# save graph as jpeg (can also save as tiff, png, pdf by changing the file extension)
ggsave('2022_species_presence_graph.jpeg',
       species_presence_plot,
       path = 'figures',
       width = 12,
       height = 10,
       units = 'in',
       dpi = 600)
 

# 3. Proportion monthly detections ----------------------------------------


# we need to use the deployment data to determine how many days each camera was active for

# this script modified from Becca Smith, MSc should do just that!

deploy_active <- deploy_fixed %>% 
  
  # for each row, create a sequence between the start and end dates, and make a new row for that for each date
  rowwise() %>% 
  do(data.frame(array = .$array, 
                site = .$site, 
                start = .$start_date, 
                end = .$end_date, 
                day = seq(.$start_date, .$end_date, by = "1 day"))) %>% 
  # Create a new column that determines which month each of your dates is in
  mutate(month = month(day),
         year = year(day)) %>% 
  
  # group by site, month and year
  group_by(site, month, year) %>% 
  
  # Determine number of days per month camera is active
  mutate(days_month = length(unique(day))) %>% 
  
  # get distinct rows for each 
  distinct(site, month, year, 
           .keep_all = TRUE) %>% 
  
  # mark which months have < 15 days active to be removed later
  mutate(remove = case_when(days_month <15 ~ 'remove',
                            days_month >=15 ~ 'keep'))


# calculate the total number of months each camera was active for including only those active for >15 days/month or the 'keep' values

deploy_months_active <- deploy_active %>% 
  
  # keep only months camera active >15 days
  filter(remove == 'keep') %>% 
  
  # group by site and month
  group_by(site) %>% 
  
  # count total number of months active
  summarise(months_active = n()) 

# we will use this data later


# now that we have  identified cameras that were not active long enough each month to reliably extract data from we can use that column to remove this data from the detections data frame

proportional_detections <- detections %>% 
  
  # join data to the deploy_active data frame
  left_join(deploy_active,
            by = c('site',
                   'month',
                   'year')) %>% 
  
  # filter by only those we identified as 'keep' (i.e. camera working >=15 days/month)
  filter(remove == 'keep') %>% 
  
  # get a distinct row for each species at each site for each month and year
  distinct(site, 
           species, 
           month,
           year) %>% 
  
  # group by site and species to create data frame with one row per site x species combo
  group_by(site, 
           species) %>% 
  
  summarise(months_present = n()) %>% 
  
  # ungroup data
  ungroup() %>% 
  
  # filter to only species in the list of focal species we created earlier
  # NOTE when we do this we lose 3 sites because there weren't any of these species detected at those sites during months where the camera was active >= 15 days/month
  filter(species %in% focal_species) %>% 
  
  # pivot the data wider so there is a column for each species and 1 row per site
  pivot_wider(names_from = species,
              values_from = months_present) %>% 
  
  # replace NAs with zeros in all species columns
  mutate(across(
    where(is.numeric),
    ~ replace_na(., 0))) %>% 
  
  # add column for total months each camera was active from the deploy_months_active object we created earlier
  
  left_join(deploy_months_active,
            by = 'site') %>% 
  
  # ensure all species columns are numeric not integer
  mutate_if(is.integer,
            as.numeric)
  

# run a function to create columns for absences based on presence data and how many months the camera was functioning

# first convert data to data frame not a tibble for function to work
proportional_detections <- as.data.frame(proportional_detections)

# create a vector of the species columns for the loop
# use all species columns (this value may change year to year)
cols <- 2:12

for (col in cols) {
  if (is.numeric(proportional_detections[,col]) & is.numeric(proportional_detections[,13])) 
    {new_col_name <- paste0("absent_", colnames(proportional_detections)[col])
    proportional_detections[new_col_name] <- proportional_detections[,13] - proportional_detections[,col]
  }
}


# rename columns for species because R doesn't like spaces
proportional_detections <- proportional_detections %>% 
  
  # set the column names to lower case and replace the spaces with '_' (these are both personal preferences of mine)
  set_names(
    names(.) %>% 
      tolower()%>% 
      str_replace_all(pattern = ' ',
                      replacement = '_'))



# fix bear data

# before we can use this data we need to adjust the columns for bears since they are hibernating we don't want to calculate their presence/absence for those inactive months

# For bears we want to subset further and have months_active not include Dec-March
  
# now let's recalculate the number of active months 
months_active_bears <- deploy_active %>% 
  
  # filter to months bears are active (April - November)
  dplyr::filter(month %in% c("4", "5", "6", "7", "8", "9", "10", "11")) %>% 
  
  # get distinct rows for each 
  distinct(site, month, year, 
           .keep_all = TRUE) %>% 
  
  # group by site
  group_by(site) %>% 
  
  # count the number of months active during bear active season and save as new column
  summarise(months_active_bears = n())
 

# now we overwrite the absent column for black bears using new info

proportional_detections_bears <- proportional_detections %>% 
  
  # join the bear active data
  left_join(months_active_bears, 
            by = 'site') %>% 
  
  # overwrite absent black bear column
  mutate(absent_black_bear = months_active_bears - black_bear) %>%
  
  # get rid of unnecessary columns for active months
  select(-c(months_active, 
            months_active_bears))

 
# save data
write_csv(proportional_detections_bears,
          'data/processed/OSM_2022_proportional_detections.csv')


