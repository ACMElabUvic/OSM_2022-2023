
# Detections LU01 --------------------------------------------------------------------


#LU01
detection_plot_LU1 <- ggplot(data = detection_data$LU01, 
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
  
  # add title to plot with LU name
  
  ggtitle("LU1 Detections")+
  
  # set the theme
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

# view plot
detection_plot_LU1

# save plot
ggsave('figures/detection_plot_LU1_2022.tiff',
       detection_plot_LU1,
       dpi = 600,
       width = 11,
       height = 9,
       units = 'in')


### repeat for each LU


# Detections LU13 --------------------------------------------------------------------

# LU13
detection_plot_LU13 <- ggplot(detection_data$LU13,
                              aes(x= reorder(species, count), y = count)) +
  
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
  
  # add title to plot with LU name
  
  ggtitle("LU13 Detections")+
  
  # set the theme
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

# view plot
detection_plot_LU13

# save plot
ggsave('figures/detection_plot_LU13_2022.tiff',
       detection_plot_LU13,
       dpi = 600,
       width = 11,
       height = 9,
       units = 'in')



# Detections LU15 --------------------------------------------------------------------

# LU15
detection_plot_LU15 <- ggplot(detection_data$LU15,
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
  
  # add title to plot with LU name
  
  ggtitle("LU15 Detections")+
  
  # set the theme
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

# view plot
detection_plot_LU15

# save plot
ggsave('figures/detection_plot_LU15_2022.tiff',
       detection_plot_LU15,
       dpi = 600,
       width = 11,
       height = 9,
       units = 'in')



# Detections LU21 --------------------------------------------------------------------

# LU21
detection_plot_LU21 <- ggplot(detection_data$LU21,
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
  
  # add title to plot with LU name
  
  ggtitle("LU21 Detections")+
  
  # set the theme
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

# view plot
detection_plot_LU21

# save plot
ggsave('figures/detection_plot_LU21_2022.tiff',
       detection_plot_LU21,
       dpi = 600,
       width = 11,
       height = 9,
       units = 'in')




# Naive occ LU1 ---------------------------------------------------------------------

#LU1
naive_occ_plot_LU1 <- ggplot(naive_occ_data$LU01,
                             aes(x = fct_reorder(species,
                                                 ind_det),
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
       y = 'Proportion of Sites With At Least One Detection',
       title = 'LU1 Naive Occupancy') +
  
  # set. theme elements
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5))


# view plot
naive_occ_plot_LU1

# save plot
ggsave('figures/naive_occ_LU1_2022.tiff',
       naive_occ_plot_LU1,
       dpi = 600,
       width = 11,
       height = 9,
       units = 'in')

# repeat for each LU


# Naive occ LU13 ----------------------------------------------------------

# LU13
naive_occ_plot_LU13 <- ggplot(naive_occ_data$LU13,
                              aes(x = fct_reorder(species,
                                                  ind_det),
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
       y = 'Proportion of Sites With At Least One Detection',
       title = 'LU13 Naive Occupancy') +
  
  # set. theme elements
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5))


# view plot
naive_occ_plot_LU13

# save plot
ggsave('figures/naive_occ_LU13_2022.tiff',
       naive_occ_plot_LU13,
       dpi = 600,
       width = 11,
       height = 9,
       units = 'in')


# Naive occ LU15 ----------------------------------------------------------

# LU15
naive_occ_plot_LU15 <- ggplot(naive_occ_data$LU15,
                              aes(x = fct_reorder(species,
                                                  ind_det),
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
       y = 'Proportion of Sites With At Least One Detection',
       title = 'LU15 Naive Occupancy') +
  
  # set. theme elements
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5))


# view plot
naive_occ_plot_LU15

# save plot
ggsave('figures/naive_occ_LU15_2022.tiff',
       naive_occ_plot_LU15,
       dpi = 600,
       width = 11,
       height = 9,
       units = 'in')


# Naive occ LU21 ----------------------------------------------------------

# LU21
naive_occ_plot_LU21 <- ggplot(naive_occ_data$LU21,
                              aes(x = fct_reorder(species,
                                                  ind_det),
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
       y = 'Proportion of Sites With At Least One Detection',
       title = 'LU21 Naive Occupancy') +
  
  # set. theme elements
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5))


# view plot
naive_occ_plot_LU21

# save plot
ggsave('figures/naive_occ_LU21_2022.tiff',
       naive_occ_plot_LU21,
       dpi = 600,
       width = 11,
       height = 9,
       units = 'in')



