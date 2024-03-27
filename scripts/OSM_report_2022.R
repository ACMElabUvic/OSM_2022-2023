# Install packages ----------------------

# if you don't have the following packages use the code below to install them

install.packages('tidyverse') # data import, manipulation, visualization
install.packages('ggpubr')

# Libraries ----------------------

# then load the libraries for this R session

library(tidyverse) # will load all tidyverse packages, can see complete list using tidyverse_packages()
library(ggpubr) # make modificaions to plot for publication (arrange plots)


# Data --------------------------------------------------------------------

# detection data
# read in saved and cleaned detection data from the ACME_camera_script_9-2-2024.R 
detections <- read_csv('data/processed/OSM_2022_ind_det.csv') %>% 
  
  # change site, species and event_id to factor
  mutate_if(is.character,
            as.factor)


# Data formatting ---------------------------------------------------------

# the next sections will create  plots in the same format as those created for 2021-2022 OSM report. Before we can do this, we have to do a bit of data manipulation so that we keep formatting consistent across reports and can display various LUs together in a new report regardless of who made the plot.

# check the levels in 'species' and see if we can match as much as possible to 2021-2022 report which had
# white-tailed deer
# snowshoe hare
# black bear
# coyote
# red squirrel
# fisher
# unknown
# moose
# lynx
# spruce grouse
# red fox
# striped skunk
# ruffed grouse
# owl
# grey wolf
# domestic dog
# cougar
# raven
# other 
# mule deer

detections %>% 
  
  # group by array and species
  group_by(array, species) %>% 
  summarise(n = n()) %>% 
  
  # have R print everything
  print(n = nrow(.))

# now let's create a new data frame (tibble) to work with for the OSM figure summaries specifically

# I personally would lump all the unknown together and all the birds together but for the sake of consistency with last years' figures we will remove some entries, let's create a vector of entries to drop

species_drop <- c('Staff',
                  'Unknown deer',
                  'Unknown ungulate',
                  'Unknown canid',
                  'Unknown mustelid',
                  'Other birds')

# now we can create the new data frame with some changes consistent w/ choices made for 2021-2022
detections <- detections %>% 
  
  # for summarizing, lets lump all the recreational humans into "Humans"
  mutate(species = recode_factor(species, 
                                 "Snowmobiler" = "Human",
                                 "ATVer" = "Human",
                                 'Hunter' = 'Human')) %>% 
  
  # remove species we don't want to plot
  filter(!species %in% species_drop)


# we will also want to create a data frame for each LU to plot individually

# LU1
dets_LU1 <- detections %>% 
  filter(array == 'LU01')

# LU13
dets_LU13 <- detections %>% 
  filter(array == 'LU13')

# LU15
dets_LU15 <- detections %>% 
  filter(array == 'LU15')

# LU21
dets_LU21 <- detections %>% 
  filter(array == 'LU21')


# ANDREW ------------------------------------------------------------------

# can you make the above code into a forloop which assigns each new data frame created from subsetting as dets_LUname?

####


# Detection plot data -----------------------------------------------------


# apply the same formatting to each LU data frame using purrr map
detection_data <- list(dets_LU1,
                       dets_LU13,
                       dets_LU15,
                       dets_LU21) %>% 
  
  purrr::map(
    ~.x %>% 
      
      # group by species
      group_by(species) %>%
      
      # calculate a column with unique accounts of each species
      mutate(count = n_distinct(event_id)) %>% 
      
      # keep just the columns we need
      select(species, count) %>% 
      
      # keep only unique (distinct) rows so we should be left with one row per species, this helps with plotting later if you don't do it ggplot will try to count and plot each row it's annoying
      distinct()) %>% 
  
  # set names of list objects
  purrr::set_names('Detections LU01',
                   'Detections LU13',
                   'Detections LU15',
                   'Detections LU21')


# Detection plots ------------------------------------------


### now to graph independent detections for each LU using purrr, this avoids a TON of code repetition needed to plot each one individually

# create object detection plots which uses the detection_data list (w/ all 4 LUs)
detection_plots <- detection_data %>% 
  
  # use imap instead of map as it allows us to use .y to paste the list element names as the plot titles later
  purrr::imap(
    ~.x %>% 
      
      # now just copy and paste the ggplot code for the detection graphs
      ggplot(.,
             aes(x = reorder(species, count), y = count)) +
      
      # plot as bar graph using geom_col so we don't have to provide a y aesthetic
      geom_col() +
      
      # switch the x and y axis
      coord_flip() +
      
      # add the number of detections at the end of each bar
      geom_text(aes(label = count),
                color = "black",
                size = 3,
                hjust = -0.3,
                vjust = 0.2) +
      
      # label x and y axis with informative titles
      labs(x = 'Species',
           y = 'Number of Independent (30 min) Detections') +
      
      # add title to plot with LU name the .y will take the name of whatever you named each list element in the detection_data list, so make sure this name is what you want on the ggtitle
      ggtitle(.y) +
      
      # set the theme
      theme_classic() +
      theme(plot.title = element_text(hjust = 0.5)))


# view plots, this will print each in it's own window so you have to scroll back in the plot viewer pane to look at each one
detection_plots

# save plots only use if needed
purrr::imap(
  detection_plots,
  ~ggsave(.x,
             file = paste0("figures/",
                           .y,
                           '.jpg'), # avoid using .tiff extension in the github repo, those files are too large to push to origin
          dpi = 600,
          width = 11,
          height = 9,
          units = 'in'))



# Naive occupancy data ---------------------------------------------------

# First we need to alter the data frame a bit for these plots, let's create a data frame for each LU (I couldn't figure out how to do this without assigning individual data frames for each UGH)


# apply the same formatting to each data frame using purrr
occupancy_data <- list(dets_LU1,
                       dets_LU13,
                       dets_LU15,
                       dets_LU21) %>% 
  
  purrr::map(
    ~.x %>% 
      
      # calculate the total number of sites for each LU
      mutate(total_sites = n_distinct(site)) %>% 
      
      # group by species to calculate the number of sites each spp occurred at
      group_by(species) %>% 
  
      # add columns to count the number of sites each spp occurred at and then the naive occupancy
  reframe(count = n_distinct(site),
          naive_occ = count/total_sites,
          ind_det = n_distinct(event_id)) %>% 
  
    # keep just the columns we need
  select(species, naive_occ, ind_det) %>% 
  
    # keep only unique (distinct) rows so we should be left with one row per species, this helps with plotting
  distinct()) %>% 
  
  purrr::set_names('Naive Occupancy LU01',
                   'Naive Occupancy LU13',
                   'Naive Occupancy LU15',
                   'Naive Occupancy LU21')

# now let's plot!


# Naive occupancy plots ---------------------------------------------------

### now to graph naive occupancy for each LU using purrr, this avoids a TON of code repetition needed to plot each one individually

# create object occupancy_plots which uses the occupancy_data list (w/ all 4 LUs)
occupancy_plots <- occupancy_data %>% 
  
  # use imap instead of map as it allows us to use .y to paste the list element names as the plot titles later
  purrr::imap(
    ~.x %>% 

      # now just copy and paste the ggplot code for the occupancy graphs
      ggplot(.,
             aes(x = fct_reorder(species,
                                 ind_det), # this reorders the species so they match the order of the detection plot which makes it better for viewing when the plots are arranged together in 1 figure for each LU
                 y = naive_occ)) +
      
      # plot as bars using geom_col() which uses stat = 'identity', instead of geom_bar() which will count the rows in each group and plot that instead of naive occ
      geom_col() +
      
      # flip x and y axis 
      coord_flip() +
      
      # add text to end of bars that provides naive occ value
      geom_text(aes(label = round(naive_occ, 2)), 
                size = 3, 
                hjust = -0.3, 
                vjust = 0.2) +
      
      # relabel x and y axis and title
      labs(x = 'Species',
           y = 'Proportion of Sites With At Least One Detection') +
      
      # set plot title using .y (name of list object)
      ggtitle(.y) +
      
      # set. theme elements
      theme_classic()+
      theme(plot.title = element_text(hjust = 0.5)))

# view plots
occupancy_plots

# save plots 
purrr::imap(
  occupancy_plots,
  ~ggsave(.x,
          file = paste0("figures/",
                        .y,
                        '.jpg'), # avoid using .tiff extension in the github repo, those files are too large to push to origin
          dpi = 600,
          width = 11,
          height = 9,
          units = 'in'))


# Final combined plots for report --------------------------------------------------

# not sure I know how to do the following section in purrr just yet, but we've saved a ton of coding so far and it doesn't take much to arrange each of these individually

# LU1

# arrange the plots so each LU has a figure with detections on top and naive occ on bottom
LU1_det_occ_plots <- ggarrange(detection_plots$`Detections LU01`, occupancy_plots$`Naive Occupancy LU01`,
                               labels = c("A", "B"),
                               nrow = 2)

# view plot
LU1_det_occ_plots

# LU13

# arrange the plots so each LU has a figure with detections on top and naive occ on bottom
LU13_det_occ_plots <- ggarrange(detection_plots$`Detections LU13`, occupancy_plots$`Naive Occupancy LU13`,
                               labels = c("A", "B"),
                               nrow = 2)

# view plot
LU13_det_occ_plots


# LU15

# arrange the plots so each LU has a figure with detections on top and naive occ on bottom
LU15_det_occ_plots <- ggarrange(detection_plots$`Detections LU15`, occupancy_plots$`Naive Occupancy LU15`,
                                labels = c("A", "B"),
                                nrow = 2)

# view plot
LU15_det_occ_plots


# LU21

# arrange the plots so each LU has a figure with detections on top and naive occ on bottom
LU21_det_occ_plots <- ggarrange(detection_plots$`Detections LU21`, occupancy_plots$`Naive Occupancy LU21`,
                                labels = c("A", "B"),
                                nrow = 2)

# view plot
LU21_det_occ_plots


# save all figures at once using purrr
final_det_occ_plots <- list(LU1_det_occ_plots,
                            LU13_det_occ_plots,
                            LU15_det_occ_plots,
                            LU21_det_occ_plots) %>% 
  

  purrr::set_names('LU01_det_occ_plots',
                   'LU13_det_occ_plots',
                   'LU15_det_occ_plots',
                   'LU21_det_occ_plots') %>% 
  
  purrr::imap(
    ~ggsave(.x,
            file = paste0("figures/",
                          .y,
                          '.jpg'), # avoid using .tiff extension in the github repo, those files are too large to push to origin
            dpi = 600,
            width = 12,
            height = 15,
            units = 'in'))



