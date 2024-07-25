This README file was generated on 2024-07-17 by Marissa A. Dyck

# OSM Data for 2021-2023
This readme file explains the data from Dr. Jason Fisher's lab for the OSM project for sampling years 2021-2022 and 2022-2023

<hr>

### GENERAL INFORMATION

**1. Project Information**   
Details for the Oil Sands Monitoring Program study design can be found [here](https://open.alberta.ca/publications/9781460151341)  

Also visit the [ACME website](http://www.acmelab.ca/osm2022.html) more information about the OSM project and the ACME lab.

**2. Author Information**

**A. Principal Investigator Contact Information** 
Name: Dr. Jason T Fisher  
Institution: University of Victoria 
Address: School of Environmental Studies, University of Victoria, PO Box 1700 STN CSC, Victoria, British Columbia V8W 2Y2, Canada  
ORCID: 0000-0002-9020-6509    
Email: [fisherj@uvic.ca](mailto:fisherj@uvic.ca)  

**B. Secondary Contact Information**   
Name: Dr. Marissa A. Dyck   
Institution: University of Victoria   
Address: School of Environmental Studies, University of Victoria, PO Box 1700 STN CSC, Victoria, British Columbia V8W 2Y2, Canada  
ORCID: 0000-0002-6371-0646  
Email: [marissadyck@uvic.ca](mailto:marissadyck@uvic.ca)    
		
**C. Alternate Contact Information**  
Name: Dr. Andrew F. Barnas  
Institution: University of Victoria   
Address: School of Environmental Studies, University of Victoria, PO Box 1700 STN CSC, Victoria, British Columbia V8W 2Y2, Canada  
ORCID:0000-0003-0990-4666   

**D. Alternate Contact Information**  
Name: Rebecca Smith   
Institution: University of Victoria   
Address: School of Environmental Studies, University of Victoria, PO Box 1700 STN CSC, Victoria, British Columbia V8W 2Y2, Canada  
ORCID: 0000-0002-3569-399X    

**E. Alternate Contact Information**  
Name: Emerald Arthurs   
Institution: University of Victoria   
Address: School of Environmental Studies, University of Victoria, PO Box 1700 STN CSC, Victoria, British Columbia V8W 2Y2, Canada    
  
**F. Alternate Contact Information**  
Name: Megan Braun   
Institution: University of Victoria   
Address: School of Environmental Studies, University of Victoria, PO Box 1700 STN CSC, Victoria, British Columbia V8W 2Y2, Canada  

**3. Date of data collection:** 2022-2023   

**4. Geographic location of data collection:** Alberta, Canada    

**5. Information about funding sources that supported the collection of the data:** Data collection was funded by the Oil Sands Monitoring Program: it is a contribution to the Program but does not necessarily reflect the position of the Program. 

### DATA & FILE OVERVIEW

**File List:**  

*  <span style = "color: #7B0F17;">**01_ACME_Camera_Image_Processing_Protocol.pdf**</span>; Document that provides detailed information describing how mammal species data in *OSM_camera_data_2021-2022.csv* were extracted from remote cameras’ SD cards   

*  <span style = "color: #7B0F17;">**OSM_ABMI_covariates_grouping_table**</span>; Document that defines each human footprint variable and how the raw data were grouped into variables found in *OSM_landscape_data_2021-2022.csv*  

* <span style = "color: #7B0F17;">**OSM_camera_data_2021-2022.csv**</span>; Contains camera image data (e.g. species name, counts, date, time, etc.) and site data for each camera (e.g. lat/lon location, elevation, etc.)  

* <span style = "color: #7B0F17;">**OSM_landscape_data_2021-2022.csv**</span>; Contains landscape data (human factors indices & land cover classes) and site data for each camera location (e.g. lat/lon location, elevation, etc.)  

### DATA-SPECIFIC INFORMATION FOR: [<span style = "color: #7B0F17;">OSM_camera_data_2021-2022.csv</span>]  

* **Number of variables/columns:** 62
* **Number of observations/rows:** 397,283

**Variable List:**

<span style = "color: #2274A5;">rootfolder</span>   
Description: Original folder images are stored in 
Type: Character 
	
<span style = "color: #2274A5;">file </span>     
Description: The unique file name for the raw images for each camera    
Type: Character   
Values: Unique to each image/row    

<span style = "color: #2274A5;">deleteflag</span>      
Description: 
Type: Logical   
Values: TRUE/FALSE    

<span style = "color: #2274A5;">site</span>     
Description: unique identifier where the first element abbreviation describes the landscape unit (i.e. LU2 or LU3) and the second element describes the camera site    
Type: categorical   
Values: Unique to each camera   

<span style = "color: #2274A5;">classifier</span>     
Description: initials of the individual who classified the data in the image    
Type: Character   
	
<span style = "color: #2274A5;">snow</span>     
Description: Ground snow cover determined by the classifier. With '0' being no snow cover, '100' being snow that covers the whole ground, and 'Deep' snow cover with a depth greater than or equal to 1  meter.    
Type: categorical with 5 levels   
Values: 0, <50, >50, 100, Deep    

<span style = "color: #2274A5;">species</span>    
Description: the animal in the image identified to the species level if possible, if species cannot be determined the lowest possible classification is used following unknown (e.g. unknown canid). If no identification can be made the image is classified as unknown.    
Type: categorical   
Values: See data for complete list of species   

<span style = "color: #2274A5;">total</span>   
Description: the number of individuals present in frame   
Type: Numeric   
Units: Counts   

*NOTE: Demographic information (sex and age) only needs to be filled out for species of interest (i.e. all ungulates except cows, wolf, bear, cougar). As a rule, we will specify sex and age (including UnknownSex/Age) for all species larger than a coyote. For smaller species (i.e. mustelids, hare, mesocarnivores), unless there is evidence to distinguish sex/age (e.g. an adult female with young in tow), demographic information can be left blank.	* 

<span style = "color: #2274A5;">male</span>   
Description: number of individuals for sex class male, if sex is distinguishable, present in frame  
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">female</span>   
Description: number of individuals for sex class female, if sex is distinguishable, present in frame  
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">unknownsex</span>     
Description: number of individuals of which sex is indistinguishable present in frame   
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">adult</span>    
Description: number of individuals in this age group present in frame. See ACME_Camera_Image_Processing_Protocol.pdf for full descriptions of how each age group is classified per species.    
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">yly</span>    
Description: number of individuals in this age group (yearling) present in frame. See ACME_Camera_Image_Processing_Protocol.pdf for full descriptions of how each age group is classified per species.    
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">yoy</span>    
Description: number of individuals in this age group (young of year) present in frame. See ACME_Camera_Image_Processing_Protocol.pdf for full descriptions of how each age group is classified per species.    
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">group_count</span>    
Description: the number of individuals present across the entire sequence (images taken within 1 minute of one another)    
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">g_male</span>     
Description: number of individuals for sex class male, if sex is distinguishable, present in the entire sequence.    
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">g_female</span>   
Description: number of individuals for sex class female, if sex is distinguishable, present in the entire sequence.    
Type: Numeric
Units: Counts

<span style = "color: #2274A5;">G_UnknownSex</span>     
Description: number of individuals of which sex is indistinguishable present in the entire sequence   
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">a_adult</span>    
Description: number of individuals in this age group present in the entire sequence. See ACME_Camera_Image_Processing_Protocol.pdf for full descriptions of how each age group is classified per species.    
Type: Numeric      
Units: Counts       

<span style = "color: #2274A5;">g_yly</span>   
Description: number of individuals in this age group (yearling) present in the entire sequence. See ACME_Camera_Image_Processing_Protocol.pdf for full descriptions of how each age group is classified per species.  
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">g_yoy</span>   
Description: number of individuals in this age group (young of year) present in the entire sequence. See ACME_Camera_Image_Processing_Protocol.pdf for full descriptions of how each age group is classified per species.   
Type: Numeric   
Units: Counts   

<span style = "color: #2274A5;">event</span>   
Description: used to denote the start and end of an event sequence  
Type: categorical with two levels   
Values: Start, End    

<span style = "color: #2274A5;">empty</span>    
Description: denotes if an image is blank   
Type: Logical   
Values: True/False    

*NOTE: The following information is for partial identity (coat colour and antlers)*

<span style = "color: #2274A5;">coatcolour</span>   
Description: Indicates the coat colour of species of interest.  See ACME_Camera_Image_Processing_Protocol.pdf for full descriptions of how coatcolour is determined   
Type: categorical   
Values: Varies among species    

<span style = "color: #2274A5;">leftantler</span>     
Description: the number of antler points on the left side for ungulates classified as male    
Type: Numeric   
Values: Counts    

<span style = "color: #2274A5;">rightantler</span>   
Description: the number of antler points on the right side for ungulates classified as male   
Type: Numeric   
Values: Counts    

<span style = "color: #2274A5;">lcount</span>   
Description: classification of how visible the antlers are for the LeftAntler counts. With 'Total' indicating there is a a clear and unambiguous view of the complete antler for the classifier to count all points and 'Minimum' if the antler was partially obscured or the classifier was unable to count all points.   
Type: categorical with two levels   
Values: Total, Minimum    

<span style = "color: #2274A5;">rcount</span>   
Description: classification of how visible the antlers are for the RightAntler counts. With 'Total' indicating there is a a clear and unambiguous view of the complete antler for the classifier to count all points and 'Minimum' if the antler was partially obscured or the classifier was unable to count all points.   
Type: categorical with two levels   
Values: Total, Minimum	    

<span style = "color: #2274A5;">cameramalfunction</span>   
Description: identifies any camera malfunctions that would compromise the ability to detect wildlife or compromises the data (e.g. wrong date time stamp)    
Type: Character   
Values: Varies    

<span style = "color: #2274A5;">otherspecify</span>   
Description: Additional comments box to populate anytime “OtherSpecify” is selected from the drop-down menu of another category. See ACME_Camera_Image_Processing_Protocol.pdf for when this may be used.    
Type: Character   
Values: Varies    

<span style = "color: #2274A5;">comments</span>   
Description: additional comments from the classifier    
Type: Character   
Values: Varies    

<span style = "color: #2274A5;">Nnteworthy</span>     
Description: a way to flag images that are particularly exciting that lab personnel may want to use in the future for presentations, etc.    
Type: Logical   
Values: TRUE/FALSE    

<span style = "color: #2274A5;">datetime</span>     
Description: the date and time population from the camera image, formatted as yyyy-mm-dd hh:mm:ss   
Type: DateTime    

<span style = "color: #2274A5;">folder</span>   
Description: a column autopopulated from the timelapse software, we do not use so all values are NA 
Values: NA    

<span style = "color: #2274A5;">imagequality</span>   
Description: 

<span style = "color: #2274A5;">month</span>  
Description: the month the photo was taken, extracted from the datetime column for use with data analysis 
Type: Factor or numeric 
Values: 1 - 12  

<span style = "color: #2274A5;">year</span>  
Description: the year the photo was taken, extracted from the datetime column for use with data analysis 
Type: Factor or numeric 
Values: 2021 - 2023 

<span style = "color: #2274A5;">deploy_date</span>    
Description: date when the camera was deployed  
Type: Date    
Values: Unique for each camera    

<span style = "color: #2274A5;">deploy_time</span>   
Description: time when the camera was deployed    
Type: Time (24 hours)   
Values: Unique for each camera    

<span style = "color: #2274A5;">crew</span>  
Description: the initials of the crew who deployed the camera   
Type: categorical   
Values: Varies per camera   

<span style = "color: #2274A5;">grid_cell</span>    
Description: unique identifier where the first element abbreviation describes the landscape unit (i.e. LU1, LU2, LU3 etc.) and the second element describes the camera site   
Type: categorical   
Values: Unique for each camera    

<span style = "color: #2274A5;">camera_unit</span>  
Description: a unique character identifier for the infrared camera unit that was deployed   
Type: categorical   
Values: Unique for each camera    

<span style = "color: #2274A5;">sd</span>   
Description: a unique character identifier for the SD card that was deployed with the camera unit   
Type: categorical   
Values: Unique for each camera    

<span style = "color: #2274A5;">lat</span>  
Description: latitudinal geographic coordinates for the camera location   
Type: Numeric   
Units: in decimal degrees   

<span style = "color: #2274A5;">long</span>  
Description: longitudinal geographic coordinates for the camera location    
Type: Numeric   
Units: in decimal degrees   

<span style = "color: #2274A5;">gps_label</span>  
Description: unique identifier where the first element abbreviation describes the landscape unit (i.e. LU1, LU13, LU15, or LU21) and the second element describes the camera site.    
Type: categorical     
Values: Unique for each camera    

<span style = "color: #2274A5;">ecosite</span>   
Description: describing the eco-type at the camera site     
Type: categorical with 3 levels     
Values: lowland, upland, unknown    

<span style = "color: #2274A5;">site_description</span>   
Description: a description of the vegetation at the camera site, made by the staff deploying the cameras.   
Type: Character   
Values: Unique for each camera    

<span style = "color: #2274A5;">topography</span>   
Description: description of topography at the camera site   
Type: categorical with 3 levels   
Values: Flat, Slope, Ridge    

<span style = "color: #2274A5;">grade</span>  
Description: measurement of the slop (incline/decline) of the camera site       
Type: Numeric   
Units: Percent    

<span style = "color: #2274A5;">elevation</span>  
Description: measurement of the elevation at the camera site    
Type: Numeric   
Units: Meters   

<span style = "color: #2274A5;">dist_trail</span>   
Description: measurement of the distance from the camera site to the nearest trail    
Type: Numeric   
Units: Meters   

<span style = "color: #2274A5;">camera_direction</span>  
Description: the cardinal direction the camera was pointed    
Type: categorical with 8 levels     
Values: NE, N, NW, W, E, SE, S, SW    

<span style = "color: #2274A5;">trail_rating</span>   
Description: estimate of how much the game trail is used recorded by field staff, with 1 being low use and 3 being high use   
Type: Ordered categorical 
Values: 1, 2, 3   

<span style = "color: #2274A5;">dist_lure</span>  
Description: measurement of the distance from the camera to the scent lure used to attract mammals    
Type: Numeric   
Units: Meters   

<span style = "color: #2274A5;">site_comments</span>   
Description: notes for the field crew   
Type: Character   
Values: Unique for each camera    

<span style = "color: #2274A5;">forest</span>   
Description: forest type recorded by field personnel    
Type: Categorical     


**4. Missing data codes:** "NA" is used for missing data  

**5. Specialized formats or other abbreviations used:** Any abbreviations used are described above  


### DATA-SPECIFIC INFORMATION FOR: [<span style = "color: #7B0F17;">OSM_landscape_data_2021-2022.csv</span>]  

* Human footprints indices were downloaded from the [ABMI human footprints wall to wall data download website for Year 2021](https://abmi.ca/home/data-analytics/da-top/da-product-overview/Human-Footprint-Products/HF-inventory.html) and were grouped according to the *OSM_ABMI_covariates_grouping_table*.      
* Land cover class data were downloaded from the [ABMI data archive wall to wall landcover inventory data download website for Year 2010](https://abmi.ca/home/data-analytics/da-top/da-product-overview/Data-Archive/Land-Cover.html)   

* **Number of variables/columns:** 39   
* **Number of observations/rows:** 4661   

**Variable List:**

*NOTE: Unless otherwise specified, the variables in this file are of type = numeric, and represent proportions of a specific human footprints indices or landcover types within the designated buffer around each camera. Each human footprint index is described in detail in the* **OSM_ABMI_covariates_grouping_table**    

<span style = "color: #2274A5;">array</span>   
Description: Identifier that describes the lanscape unit 
Type: Categorical 
Values: LU1, LU2, LU3, LU13, LU15, LU21   

<span style = "color: #2274A5;">site</span>     
Description: unique identifier where the first element abbreviation describes the landscape unit (i.e. LU2 or LU3) and the second element describes the camera site    
Type: categorical   
Values: Unique to each camera   

<span style = "color: #2274A5;">buff_dist</span>   
Description: measurement ranging from 250 - 5000 by intervals of 250, of the buffer radius around the camera for which the proportion of associated variables in this dataset were calculated     
Type: Numeric   
Units: Meters   

<span style = "color: #2274A5;">harvest</span>  

<span style = "color: #2274A5;">pipeline</span>  

<span style = "color: #2274A5;">roads</span>   

<span style = "color: #2274A5;">seismic_lines</span>   

<span style = "color: #2274A5;">seismic_lines_3D</span>  

<span style = "color: #2274A5;">trails</span>   

<span style = "color: #2274A5;">transmission_lines</span>   

<span style = "color: #2274A5;">veg_edges</span>  

<span style = "color: #2274A5;">wells</span>   

<span style = "color: #2274A5;">lc_grassland</span>   
Description: derived from lc_class110 in raw data from ABMI   

<span style = "color: #2274A5;">lc_coniferous</span>  
Description: derived from lc_class210 in raw data from ABMI   

<span style = "color: #2274A5;">lc_broadleaf</span>  
Description: derived from lc_class220 in raw data from ABMI   

<span style = "color: #2274A5;">lc_mixed</span>  
Description: derived from lc_class230 in raw data from ABMI   

<span style = "color: #2274A5;">lc_developement</span>  
Description: derived from lc_class34 in raw data from ABMI   

<span style = "color: #2274A5;">lc_shrub</span>  
Description: derived from lc_class50 in raw data from ABMI   

<span style = "color: #2274A5;">osm_industrial</span>  

<span style = "color: #2274A5;">deploy_date</span>  
Description: date when the camera was deployed  
Type: Date    
Values: Unique for each camera    

<span style = "color: #2274A5;">deploy_time</span>   
Description: time when the camera was deployed    
Type: Time (24 hours)   
Values: Unique for each camera    

<span style = "color: #2274A5;">crew</span>  
Description: the initials of the crew who deployed the camera   
Type: categorical   
Values: Varies per camera   

<span style = "color: #2274A5;">grid_cell</span>    
Description: unique identifier where the first element abbreviation describes the landscape unit (i.e. LU1, LU2, LU3 etc.) and the second element describes the camera site   
Type: categorical   
Values: Unique for each camera    

<span style = "color: #2274A5;">camera_unit</span>  
Description: a unique character identifier for the infrared camera unit that was deployed   
Type: categorical   
Values: Unique for each camera    

<span style = "color: #2274A5;">sd</span>   
Description: a unique character identifier for the SD card that was deployed with the camera unit   
Type: categorical   
Values: Unique for each camera    

<span style = "color: #2274A5;">lat</span>  
Description: latitudinal geographic coordinates for the camera location   
Type: Numeric   
Units: in decimal degrees   

<span style = "color: #2274A5;">long</span>  
Description: longitudinal geographic coordinates for the camera location    
Type: Numeric   
Units: in decimal degrees   

<span style = "color: #2274A5;">gps_label</span>  
Description: unique identifier where the first element abbreviation describes the landscape unit (i.e. LU1, LU13, LU15, or LU21) and the second element describes the camera site.    
Type: categorical     
Values: Unique for each camera    

<span style = "color: #2274A5;">ecosite</span>   
Description: describing the eco-type at the camera site     
Type: categorical with 3 levels     
Values: lowland, upland, unknown    

<span style = "color: #2274A5;">site_description</span>   
Description: a description of the vegetation at the camera site, made by the staff deploying the cameras.   
Type: Character   
Values: Unique for each camera    

<span style = "color: #2274A5;">topography</span>   
Description: description of topography at the camera site   
Type: categorical with 3 levels   
Values: Flat, Slope, Ridge    

<span style = "color: #2274A5;">grade</span>  
Description: measurement of the slop (incline/decline) of the camera site       
Type: Numeric   
Units: Percent    

<span style = "color: #2274A5;">elevation</span>  
Description: measurement of the elevation at the camera site    
Type: Numeric   
Units: Meters   

<span style = "color: #2274A5;">dist_trail</span>   
Description: measurement of the distance from the camera site to the nearest trail    
Type: Numeric   
Units: Meters   

<span style = "color: #2274A5;">camera_direction</span>  
Description: the cardinal direction the camera was pointed    
Type: categorical with 8 levels     
Values: NE, N, NW, W, E, SE, S, SW    

<span style = "color: #2274A5;">trail_rating</span>   
Description: estimate of how much the game trail is used recorded by field staff, with 1 being low use and 3 being high use   
Type: Ordered categorical 
Values: 1, 2, 3   

<span style = "color: #2274A5;">dist_lure</span>  
Description: measurement of the distance from the camera to the scent lure used to attract mammals    
Type: Numeric   
Units: Meters   

<span style = "color: #2274A5;">site_comments</span>   
Description: notes for the field crew   
Type: Character   
Values: Unique for each camera    

<span style = "color: #2274A5;">forest</span>   
Description: forest type recorded by field personnel    
Type: Categorical     


**4. Missing data codes:** "NA" is used for missing data  

**5. Specialized formats or other abbreviations used:** Any abbreviations used are described above  
