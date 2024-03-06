# OSM_2022-2023
This repository contains data, R scripts and associated outputs, and other materials necessary for the Applied Conservation and Macro Ecology (ACME) lab's Oil Sands Monitoring project for the 2022-2023 season.

<hr>

### GENERAL INFORMATION

**Project Information**   
Details for the Oil Sands Monitoring Program study design can be found [here](https://open.alberta.ca/publications/9781460151341)  

Also visit the [ACME website](http://www.acmelab.ca/osm2022.html) more information about the OSM project and the ACME lab.

**Author Information (data):**  
 Principal Investigator Contact Information  
 Name: Jason T. Fisher, PhD   
 Institution: University of Victoria  
 Address: 3800 Finnerty Rd, Victoria, BC V8P 5C2  
 Email: [fisherj@uvic.ca](mailto:fisherj@uvic.ca) 

**Author Information (code):**  
Data Analysis Contact Information  
		Name: Marissa A. Dyck  
		Institution: University of Victoria   
		Address: 3800 Finnerty Rd, Victoria, BC V8P 5C2   
		Email: [marissadyck@uvic.ca](mailto:marissadyck@uvic.ca)     

**Date of data collection:** 2022-2023

**Geographic location of data collection:** Alberta, Canada


### DATA & FILE OVERVIEW

**File List:**  

*Files in main folder*
		
* <span style = "color: #7B0F17;">**OSM_2022-2023.Rproj**</span>; R project to run code for data cleaning and analyses. 

*Files in data folder*

*/2021-2022*  
This folder includes cleaned data from the previous year of sampling for landscape units 2 and 3 (LU2 & LU3).

* <span style = "color: #7B0F17;">**data/2021-2022/ **</span>;


*/raw*  
This folder includes raw data for the current year (2022-2023). 

* <span style = "color: #7B0F17;">**data/raw/OSM_2022_Deployment_Data.csv**</span>; contains raw data pertaining to the deployment location, data, time, and functionality of the cameras used in the project.  

* <span style = "color: #7B0F17;">**data/raw/OSM_2022_Deployment_Site_Data.csv**</span>; contains raw data pertaining to the location, gps coordinates, date, time, and description of the sites where cameras were deployed for the project.  

* <span style = "color: #7B0F17;">**data/raw/OSM_LU01_LU13_LU15_HFI_2022.csv**</span>; contains raw data on human factor indices (HFI) for each site at varying buffer distances. 

* <span style = "color: #7B0F17;">**data/raw/OSM_LU01_LU13_LU15_VEG_2022.csv**</span>; contains raw data on land cover for each site at varying buffer distances. 


*/processed*  
This folder includes data for the current year (2022-2023) that has been cleaned and reformatted using scripts within this repository.   

* <span style = "color: #7B0F17;">**data/processed/OSM_2022_idv_det.csv**</span>; contains cleaned data on independent detections (30 minutes apart) for each species and all landscape units.  

* <span style = "color: #7B0F17;">**data/processed/OSM_2022_timelapse.csv**</span>; contains cleaned image data from timelapse for all species and landscape units (not formatted into independent detections).  


*Files in scripts folder*


### DATA-SPECIFIC INFORMATION FOR: [data/raw/OSM_2022_Deployment_Data.csv]  

* **Number of variables/columns:** 6
* **Number of observations/rows:** 155 (one per camera site) 

**Variable List:**

* <span style = "color: #2274A5;">**Project.ID**</span>, factor where the first element abbreviation describes the project (e.g. OSM for Oil Sands Monitoring) and the second describes the landscape unit (i.e. LU13, LU15, LU21, or LU01).  

* <span style = "color: #2274A5;">**Deployment.Location.ID**</span>, factor where the first element abbreviation describes the landscape unit (i.e. LU13, LU15, LU21, or LU01) and the second element describes the camera site.  

* <span style = "color: #2274A5;">**Camera.Deployment.Begin.Date.**</span>, date indicating when the camera was deployed.   

* <span style = "color: #2274A5;">**Camera.Deployment.End.Date**</span>, date indicating when the camera was retrieved.  

* <span style = "color: #2274A5;">**Deployment**</span>, factor indicating which the deployment for the associated camera (all are deployment 1 or D1).  

* <span style = "color: #2274A5;">**Camera.Failure.Details**</span>, character describing any issues with the camera during deployment. 


### DATA-SPECIFIC INFORMATION FOR: [data/raw/OSM_2022_Deployment_Site_Data.csv]

* **Number of variables/columns:** 21
* **Number of observations/rows:** 155 (one per camera site)  

**Variable List:**

* <span style = "color: #2274A5;">**Array**</span>, a factor with 4 levels where the first element abbreviation describes the project (e.g. OSM for Oil Sands Monitoring) and the second describes the landscape unit (i.e. LU13, LU15, LU21, or LU01). 

* <span style = "color: #2274A5;">**DeployDate**</span>, date indicating when the camera was deployed.   

* <span style = "color: #2274A5;">**Deploy Time**</span>, time (in 24hrs) indicating when the camera was deployed.   

* <span style = "color: #2274A5;">**Crew**</span>, factor with the initials of the crew who deployed the camera.   

* <span style = "color: #2274A5;">**Grid Cell #**</span>, a factor with 155 levels where the first element abbreviation describes the landscape unit (i.e. LU13, LU15, LU21, or LU01) and the second element describes the camera site.  

* <span style = "color: #2274A5;">**Camera Site #**</span>, [same as Grid Cell #] - factor where the first element abbreviation describes the landscape unit (i.e. LU13, LU15, LU21, or LU01) and the second element describes the camera site.  

* <span style = "color: #2274A5;">**Camera Unit #**</span>, a unique character identifier for the camera unit that was deployed. 

* <span style = "color: #2274A5;">**SD Card #**</span>, a unique character identifier for the SD card that was deployed with the camera unit.  

* <span style = "color: #2274A5;">**Lat**</span>, numeric latitudinal geographic coordinates for the camera location.   

* <span style = "color: #2274A5;">**Long**</span>, numeric longitudinal geographic coordinates for the camera location. 

* <span style = "color: #2274A5;">**GPS Label**</span>, factor with 155 levels where the first element abbreviation describes the landscape unit (i.e. LU13, LU15, LU21, or LU01) and the second element describes the camera site. 

* <span style = "color: #2274A5;">**Forest Type**</span>, factor with 4 levels describing the type of forest at the camera site (i.e. Broadleaf, Mixed, Conifer, or Coniferous).  

* <span style = "color: #2274A5;">**Camera Site Description**</span>, ???

* <span style = "color: #2274A5;">**Topography**</span>, a factor with 3 levels describing the topography of the camera site (i.e. Flat, Slope, or Ridge). 

* <span style = "color: #2274A5;">**Grade (%)**</span>, a numeric measurement of the slop (incline/decline) of the camera site. 

* <span style = "color: #2274A5;">**Elevation (m)**</span>, a numeric measurement of the elevation in meters of the camera site.   

* <span style = "color: #2274A5;">**Distance to Trail (m)**</span>, a numeric measurement of the distance to the nearest trail in meters.  

* <span style = "color: #2274A5;">**Camera Direction**</span>, a factor with 8 levels indication the cardinal direction the camera was pointed (i.e. NE, N, NW, W, E, SE, S, SW). 

* <span style = "color: #2274A5;">**Trail Use Rating**</span>, a factor ??

* <span style = "color: #2274A5;">**Distance to Lure**</span>, a numeric measurement of the distance from the camera to the lure in meters. 

* <span style = "color: #2274A5;">**Comments and Access Notes**</span>, a character with notes for the field crew.   


### DATA-SPECIFIC INFORMATION FOR: [data/raw/OSM_LU01_LU13_LU15_LU21_HFI_2022.csv]  

*Information on exact methods for data extraction and more specific variable descriptions can be found on the [ABMI human footprints wall to wall data download website for Year 2021](https://abmi.ca/home/data-analytics/da-top/da-product-overview/Human-Footprint-Products/HF-inventory.html)* **OR** *in the relevant_literature folder of this repository (HFI_2021_v1_0_Metadata_Final.pdf)*. 

* **Number of variables/columns:** 61
* **Number of observations/rows:** 3100 

**Variable List:**

* <span style = "color: #2274A5;">**Site**</span>, a factor with 155 levels where the first element abbreviation describes the landscape unit (i.e. LU13, LU15, LU21, or LU01) and the second element describes the camera site.  

* <span style = "color: #2274A5;">**BUFF_DIST**</span>, a numeric measurement in meters ranging from 250 - 5000, of the buffer radius around the camera for which the proportion of associated human factors variables were calculated.  

* <span style = "color: #2274A5;">**FEATURE_TYHARVEST.AREA**</span>, a numeric variable indicating the proportion of harvest area within the buffer. Harvest area is defined as, areas where forestry operations have occurred (clear-cut, selective harvest, salvage logging, etc.), specifically areas in Alberta’s forested Green Zone where forestry operations have occurred (clear-cut, selective harvest, salvage logging, etc.). 

* <span style = "color: #2274A5;">**FEATURE_TYCROP**</span>, a numeric variable indicating the proportion of crop within the buffer. Crop is defined as, cultivated cropland or cropland planted with annual crop species,
including farmlands that are in cultivation rotation. 

* <span style = "color: #2274A5;">**FEATURE_TYWELL.ABAND**</span>, a numeric variable indicating the proportion of abandoned wells within the buffer. Abandoned wells are defined as, ground cleared for an oil/gas well pad where the well is currently abandoned. 

* <span style = "color: #2274A5;">**FEATURE_TYWELL.OIL**</span>, a numeric variable indicating the proportion of oil wells within the buffer. Oil wells are defined as, ground cleared for an oil well pad where at least one well is currently active. 

* <span style = "color: #2274A5;">**FEATURE_TYTRAIL**</span>, a numeric variable indicating the proportion of trails within the buffer. Trails are defined as, a polygon feature class derived from a 2-meter buffer (4 meter total width) of a pre-low-impact-seismic centerline.  

* <span style = "color: #2274A5;">**FEATURE_TYHARVEST.AREA.WHITE.ZONE**</span>, a numeric variable indicating the proportion of harvest area white zone within the buffer. Harvest area white zone is defined as, areas where forestry operations have occurred (clear-cut, selective harvest, salvage logging, etc.). specifically, areas in Alberta’s unforested White Zone where woody vegetation (i.e. shrub, trees, etc..) have been removed and the purpose of the clearing has not yet been determined.  

* <span style = "color: #2274A5;">**FEATURE_TYCONVENTIONAL.SEISMIC**</span>, a numeric variable indicating the proportion of conventional seismic lines within the buffer. Conventional seismic lines are defined as, a polygon feature class derived from a 3-meter buffer (6 meter total width) of a pre-low-impact-seismic centerline.   

* <span style = "color: #2274A5;">**FEATURE_TYPIPELINE**</span>, a numeric variable indicating the proportion of pipelines within the buffer. Pipelines are defined as, a line of underground and overground pipes, of substantial length and capacity, used for the conveyance of petrochemicals. 

* <span style = "color: #2274A5;">**FEATURE_TYTAME_PASTURE**</span>, a numeric variable indicating the proportion of tame pasture within the buffer area. Tame pasture is defined as, lands where the soil has been disturbed and planted to perennial grass species used primarily for grazing livestock. Specifically, tame pasture represents areas of grasses, legumes or grass-legume mixtures planted for livestock grazing or hay collection.   

* <span style = "color: #2274A5;">**FEATURE_TYROUGH_PASTURE**</span>, a numeric variable indicating the proportion of rough pasture within the buffer area. Rough pasture is defined as, lands where the forest and/or shrubs have been removed so that native or introduced grasses can flourish for the grazing of livestock. Specifically, this pastureland has not been irrigated or fertilized and the soil has not been disturbed to improve productivity. 

* <span style = "color: #2274A5;">**FEATURE_TYRURAL.RESIDENCE**</span>, a numeric variable indicating the proportion of rural residence within the buffer area. Rural residence is defined as, country-residential developments with density of 10 - 100 buildings per quarter section.  

* <span style = "color: #2274A5;">**FEATURE_TYTRANSMISSION.LINE**</span>, a numeric variable indicating the proportion of transmission lines within the buffer area. Transmission lines are defined as, cleared corridors designated for the location of power transmission line infrastructure.  

* <span style = "color: #2274A5;">**FEATURE_TYWELL.GAS**</span>, a numeric variable indicating the proportion of gas wells within the buffer area. Gas wells are defined as, ground cleared for an gas well pad where at least one well is currently active. 

* <span style = "color: #2274A5;">**FEATURE_TYMISC.OIL.GAS.FACILITY**</span>, a numeric variable indicating the proportion of misc. oil/gas facilities within the buffer area. Misc. oil/gas facilities are defined as, human footprint features related to various industrial activities. Specifically, industrial facility used for the purpose of oil and gas. BATTERY SITE, COMPRESSOR SITE, FLARE STACK, METER STATION SITE, and VALVE SITE. 

* <span style = "color: #2274A5;">**FEATURE_TYCLEARING.UNKNOWN**</span>, a numeric variable indicating the proportion of unknown clearings within the buffer area. Unknown clearings are defined as, a human-made clearing with unknown purposes and contains no visible buildings, fences or equipment.  

* <span style = "color: #2274A5;">**FEATURE_TYVEGETATED.EDGE.ROADS**</span>, a numeric variable indicating the proportion of vegetated edge roads within the buffer area. Vegetated edge roads are defined as, disturbed vegetation alongside road edges and railway edges including ditches.  

* <span style = "color: #2274A5;">**FEATURE_TYROAD.UNIMPROVED**</span>, a numeric variable indicating the proportion of unimproved roads within the buffer area. Unimproved roads are defined as, a roadway surfaced with dirt, which is constituted as a minor access route. The road surface is up to 7 meters in width, and the
road clearing is up to 20 meters in width. The surface and ditches are poorly maintained, and the bridges are narrow. 

* <span style = "color: #2274A5;">**FEATURE_TYROAD.GRAVEL.1L**</span>, a numeric variable indicating the proportion of 1L gravel roads within the buffer area. 1L gravel roads are defined as, a roadway surfaced with gravel constituting a main access route. The road surface is about 6 meters in width, and the road clearing
is about 20 meters or greater in width. The surface, ditches, bridges and intersections are in good condition.   

* <span style = "color: #2274A5;">**FEATURE_TYROAD.GRAVEL.2L**</span>, a numeric variable indicating the proportion of 2L gravel roads within the buffer area. 2L gravel roads are defined as, a roadway surfaced with gravel constituting as a main access route. The road surface is 7 meters or greater in width, and the
road clearing is 30 meters or greater in width. The surface, ditches, bridges and intersections are in good condition.  

* <span style = "color: #2274A5;">**FEATURE_TYTRUCK.TRAIL**</span>, a numeric variable indicating the proportion of truck trails within the buffer area. Truck trails are defined as, a roadway surfaced with dirt or low vegetation constituting a minor access route.  

* <span style = "color: #2274A5;">**FEATURE_TYBORROWPITS**</span>, a numeric variable indicating the proportion of borrow pits within the buffer area. Borrow pits are defined as, excavation outside of the road right-of-way, made solely for the purpose of removing or providing borrowed material for the construction of the sub-base for a specific roadway project. It includes any other associated infrastructure such as access roads. (ALBERTA TRANSPORTAITON; GUIDE TO RECLAIMING BORROW EXCAVATIONS – 2013 Edition). Specifically, includes pits dug to build forestry and well-site roads. They are usually associated with a road or another structure. 

* <span style = "color: #2274A5;">**FEATURE_TYSUMP**</span>, a numeric variable indicating the proportion of sumps within the buffer area. Sumps are defined as, An artificial holding or treatment pond for industrial wastewater. Drilling waste storage system – holding of drilling waste on well sites or remotely. Either earthen excavation (in clayey soils) or sumps lined with a synthetic liner. 

* <span style = "color: #2274A5;">**FEATURE_TYBORROWPIT.WET**</span>, a numeric variable indicating the proportion of wet borrow pits within the buffer area. Wet borrow pits are defined as, excavation outside of the road right-of-way, made solely for the purpose of removing or providing borrowed material for the construction of the sub-base for a specific roadway project. It includes any other associated infrastructure such as access roads. (ALBERTA TRANSPORTAITON; GUIDE TO RECLAIMING BORROW EXCAVATIONS – 2013 Edition). Specifically, includes pits dug to build forestry and well-site roads. They are usually associated with a road or another structure. Presence of water confirmed by visual interpretation.   

* <span style = "color: #2274A5;">**FEATURE_TYCULTIVATION_ABANDONED**</span>, a numeric variable indicating the proportion of abandoned cultivation within the buffer area. Abandoned cultivation is defined as, agricultural land that has been formally seeded and tilled, but no evidence of present day production use. Landscape appears to have a heterogeneous mix of vegetation and closely resembles natural cover.  

* <span style = "color: #2274A5;">**FEATURE_TYURBAN.RESIDENCE**</span>, a numeric variable indicating the proportion of urban residence within the buffer area. Urban residence is defined as, residential areas in cities, towns, villages, hamlets and ribbon developments. Areas that are dominated by dwellings.  

* <span style = "color: #2274A5;">**FEATURE_TYCOUNTRY.RESIDENCE**</span>, a numeric variable indicating the proportion of country residence within the buffer area. Country residence is defined as, country-residential developments with density of 10 - 100 buildings per quarter section.  

* <span style = "color: #2274A5;">**FEATURE_TYRECREATION**</span>, a numeric variable indicating the proportion of recreational area within the buffer area. Recreation is defined as, urban/rural greenspace and recreation that does not fit into other categories (e.g. graveyards, baseball diamonds, parks, shelterbelts, ski hills, clearings from old industrial activity that is now vegetated). This layer was also used to identify green-space features that do not fit into other categories such as storage areas and parking lots.  

* <span style = "color: #2274A5;">**FEATURE_TYWELL.OTHER**</span>, a numeric variable indicating the proportion of other wells within the buffer area. Other wells are defined as, ground cleared for an oil/gas well pad where at least one well is currently active. 

* <span style = "color: #2274A5;">**FEATURE_TYWELL.BITUMEN**</span>, a numeric variable indicating the proportion of bitumen wells within the buffer area. Bitumen wells are defined as, ground cleared for an oil/gas well pad where at least one well is currently active.   

* <span style = "color: #2274A5;">**FEATURE_TYWELL.CASED**</span>, a numeric variable indicating the proportion of cased wells within the buffer area. Cased wells are defined as, ground cleared for an oil/gas well pad where at least one well is currently active.  

* <span style = "color: #2274A5;">**FEATURE_TYROAD.PAVED.UNDIV.2L**</span>, a numeric variable indicating the proportion of 2L paved roads within the buffer area. 2L paved roads are defined as, non-vegetated, impermeable surfaces used for motorized vehicle or aircraft transportation or access. Specifically, a major roadway, which is paved with asphalt or concrete, and consists of two (2) roadbeds separated by a median. Each road bed usually consists of two (2) or more lanes.  

* <span style = "color: #2274A5;">**FEATURE_TYROAD.UNCLASSIFIED**</span>, a numeric variable indicating the proportion of unclassified roads within the buffer area. Unclassified roads are defined as, non-vegetated, impermeable surfaces used for motorized vehicle or aircraft transportation or access. Specifically, a temporary coding for an unknown class of road, which will be updated after a field check or verification.   

* <span style = "color: #2274A5;">**FEATURE_TYRUNWAY**</span>, a numeric variable indicating the proportion of unclassified runways within the buffer area. Runways are defined as, human footprint related to vegetated facilities and recreation, specifically a vegetated runway.  

* <span style = "color: #2274A5;">**FEATURE_TYCLEARING.WELLPAD.UNCONFIRMED**</span>, a numeric variable indicating the proportion of unconfirmed clearing well pads within the buffer area. Unconfirmed clearing well pads are defined as, human footprint features related to various industrial activities. Specifically, roughly square in shape clearing, roughly 90-120 meters wide (approximately 1 ha). Not confirmed as a well pad by available reference sources.  

* <span style = "color: #2274A5;">**FEATURE_TYFACILITY.UNKNOWN**</span>, a numeric variable indicating the proportion of unknown facilities within the buffer area. Unknown facilities are defined as, human footprint features related to various industrial activities. Specifically, identifies areas where the reclamation liability associated for the disturbance is currently held by another industry operator.  

* <span style = "color: #2274A5;">**FEATURE_TYBORROWPIT.DRY**</span>, a numeric variable indicating the proportion of dry borrow pits within the buffer area. Dry borrow pits are defined as, excavation outside of the road right-of-way, made solely for the purpose of. removing or providing borrowed material for the construction of the sub-base for a specific roadway project. It includes any other associated infrastructure such as access roads. (ALBERTA TRANSPORTAITON; GUIDE TO RECLAIMING BORROW EXCAVATIONS – 2013 Edition). Specifically, Includes pits dug to build forestry and well-site roads. They are usually associated with a road or another structure. No presence of water. 

* <span style = "color: #2274A5;">**FEATURE_TYGRVL.SAND.PIT**</span>, a numeric variable indicating the proportion of gravel and sand pits within the buffer area. Gravel and sand pits are defined as, a human footprint features directly related to mining activities. Specifically, an area of surface disturbance for the purpose of extracting sand and/or gravel consistently open and/or expanding over multiple years, usually close to lakes or rivers. 

* <span style = "color: #2274A5;">**FEATURE_TYDUGOUT**</span>, a numeric variable indicating the proportion of dugouts within the buffer area. Dugouts are defined as, small water storage excavations that collect water from runoff from summer rains, a surplus of surface water that occurs during snowmelt in the spring or from groundwater. (Alberta Agriculture and Rural Development, QUALITY FARM DUGOUTS). 

* <span style = "color: #2274A5;">**FEATURE_TYLAGOON**</span>, a numeric variable indicating the proportion of lagoons within the buffer area. Lagoons are defined as, an artificial holding or treatment ponds for agricultural or municipal wastewater. Human made water and sewage lagoons used for municipal
purposes. 

* <span style = "color: #2274A5;">**FEATURE_TYOPEN.PIT.MINE**</span>, a numeric variable indicating the proportion of open pit mines within the buffer area. Open pit mines are defined as, human footprint features directly related to mining activities. Specifically, an area of surface disturbance for the purpose of mining (with the exception of sand and/or gravel), consistently open and/or expanding over multiple years, usually close to lakes or rivers. 

* <span style = "color: #2274A5;">**FEATURE_TYLOW.IMPACT.SEISMIC**</span>, a numeric variable indicating the proportion of low impact seismic lines within the buffer area. Low impact seismic lines are defined as, a polygon feature class derived from a 1.5-meter buffer (3 meter total width) of a pre-low-impact-seismic centerline. 

* <span style = "color: #2274A5;">**FEATURE_TYSURROUNDING.VEG**</span>, a numeric variable indicating the proportion of surrounding vegetation within the buffer area. Surrounding vegetation is defined as, human footprint related to vegetated facilities and recreation. Specifically, disturbed vegetation surrounding airport runways, highway ramps and other industrial features.   

* <span style = "color: #2274A5;">**FEATURE_TYTRANSFER_STATION**</span>, a numeric variable indicating the proportion of transfer stations within the buffer area. Transfer stations are defined as, human footprint used for the transportation, storage, and disposal of waste/garbage. Specifically, smaller area of land, less than one hectare, usually fenced with a U-shaped road and two entry ways. Used primarily for garbage drop-off and located close to municipalities or present in rural areas.  

* <span style = "color: #2274A5;">**FEATURE_TYFACILITY.OTHER**</span>, a numeric variable indicating the proportion of other facilities within the buffer area. Other facilities are defined as, human footprint features related to various industrial activities. Specifically, industrial facilities characterized by large non-residential buildings most often surrounded by concrete for parking purposes. The purpose of the facility is not disclosed. 

* <span style = "color: #2274A5;">**FEATURE_TYVEGETATED.EDGE.RAILWAYS**</span>, a numeric variable indicating the proportion of vegetated edge railways within the buffer area. Vegetated edge railways are defined as, disturbed vegetation alongside road edges and railway edges including ditches.  

* <span style = "color: #2274A5;">**FEATURE_TYFRUIT.VEGETABLES**</span>, a numeric variable indicating the proportion of fruit and vegetables within the buffer area. Fruit and vegetables are defined as, crops based on Agriculture and Agri-Food Canada (AAFC) 2014 Crop Types.  

* <span style = "color: #2274A5;">**FEATURE_TYRESIDENCE_CLEARING**</span>, a numeric variable indicating the proportion of residence clearing within the buffer area. Residence clearing is defined as, areas cleared for building developments that do not yet have any buildings.   

* <span style = "color: #2274A5;">**FEATURE_TYCFO**</span>, a numeric variable indicating the proportion of confined feeding operations within the buffer area. Confined feeding operations are defined as, confined feeding operations and other high density livestock features. 

* <span style = "color: #2274A5;">**FEATURE_TYLANDFILL**</span>, a numeric variable indicating the proportion of confined landfill within the buffer area. Landfills are defined as, human footprint used for the transportation, storage, and disposal of waste/garbage. Specifically, larger area of raised land, indicating buried garbage. Some landfills have evidence of surface revegetation and garbage dispersed throughout designated extent. They may also have large perimeter berms or fences.  

* <span style = "color: #2274A5;">**FEATURE_TYWELL_CLEARED_NOT_CONFIRMED**</span>, a numeric variable indicating the proportion of unconfirmed wellpad clearings within the buffer area. Unconfirmed wellpad clearings are defined as, human footprint features related to various industrial activities. Specifically, 
Roughly square in shape clearing, roughly 90-120 meters wide (approximately 1 ha). Not confirmed as a well pad by available reference sources. 

* <span style = "color: #2274A5;">**FEATURE_TYOIL.GAS.PLANT**</span>, a numeric variable indicating the proportion of oil/gas plants within the buffer area. Oil/gas plants are defined as, human footprint features related to various industrial activities. Specifically, Industrial facility used for oil production. REFINERIES, PLANTS, FACTORIES.  

* <span style = "color: #2274A5;">**FEATURE_TYURBAN.INDUSTRIAL**</span>, a numeric variable indicating the proportion of urban-industrial area within the buffer area. Urban-industrial area is defined as, human footprint features related to various industrial activities. Specifically, an industrial facility within the boundary of an urban residence. 

* <span style = "color: #2274A5;">**FEATURE_TYROAD.PAVED.1L**</span>, a numeric variable indicating the proportion of 1L paved roads within the buffer area. 1L paved roads are defined as, non-vegetated, impermeable surfaces used for motorized vehicle or aircraft transportation or access. Specifically, a roadway, paved with asphalt or concrete, consisting of one (1) lane.  

* <span style = "color: #2274A5;">**FEATURE_TYROAD.PAVED.UNDIV.1L**</span>, a numeric variable indicating the proportion of UNDIV 1L paved roads within the buffer area. UNDIV 1L paved roads are defined as, non-vegetated, impermeable surfaces used for motorized vehicle or aircraft transportation or access. Specifically, a roadway, paved with asphalt or concrete, consisting of one (1) lane, and usually found servicing rural acreages that are close to large urban centers. 

* <span style = "color: #2274A5;">**FEATURE_TYROAD.WINTER**</span>, a numeric variable indicating the proportion of winter roads within the buffer area. Winter roads are defined as, non-vegetated, impermeable surfaces used for motorized vehicle or aircraft transportation or access. Specifically, a clearing that is vehicular accessible in winter only.  

* <span style = "color: #2274A5;">**FEATURE_TYWELL_CLEARED_NOT_DRILLED**</span>, a numeric variable indicating the proportion of not drilled wells within the buffer area. Not drilled wells are defined as, ground cleared for an oil/gas well pad where at least one well is currently active. Specifically, a well site - confirmation of the boundary outline is provided by reference sources. 

* <span style = "color: #2274A5;">**FEATURE_TYWELL.UNKNOWN**</span>, a numeric variable indicating the proportion of unknown wells within the buffer area. Unknown wells are defined as, ground cleared for an oil/gas well pad where at least one well is currently active. Specifically, a ell site - ground cleared, well status unknown or license location. 

* <span style = "color: #2274A5;">**FEATURE_TYAIRP.RUNWAY**</span>, a numeric variable indicating the proportion of airplane runways within the buffer area. Airplane runways are defined as, non-vegetated, impermeable surfaces used for motorized vehicle or aircraft transportation or access. Specifically, an active landing facility for aircraft, usually associated with paved and lighted runways, an operating control tower, and services for aircraft and passengers. 

* <span style = "color: #2274A5;">**FEATURE_TYRESERVOIR**</span>, a numeric variable indicating the proportion of reservoirs within the buffer area. Reservoirs are defined as, an artificial lake or storage pond resulting from human-made dam. A body of water created by excavation or the man-made damming of a river or stream.  

* <span style = "color: #2274A5;">**FEATURE_TYCAMPGROUND**</span>, a numeric variable indicating the proportion of campgrounds within the buffer area. Campgrounds are defined as, human footprint related to vegetated facilities and recreation. Specifically, disturbed vegetation with frequently changing facilities of RVs and tents used for overnight stay. Most often consists of several individual clearings surrounded by vegetation and gravel or asphalt roads connecting clearings.  

* <span style = "color: #2274A5;">**FEATURE_TYCANAL**</span>, a numeric variable indicating the proportion of canals within the buffer area. Canals are defined as, a human-made watercourse built to convey water for irrigation. An irrigation canal is larger than a ditch, with reinforced banks that are usually well maintained. A human-made drainage network channels built to prepare wetland areas for anthropogenic land use. 

* <span style = "color: #2274A5;">**FEATURE_TYCAMP.INDUSTRIAL**</span>, a numeric variable indicating the proportion of industrial camps within the buffer area. Industrial camps are defined as, human footprint features related to various industrial activities. Specifically, buildings used for temporary residence by employees on or in close proximity to an industrial activity such as mining, forestry, or oil and gas activities. 

* <span style = "color: #2274A5;">**FEATURE_TYRLWY.SGL.TRACK**</span>, a numeric variable indicating the proportion of single track railways within the buffer area. Single track railways are defined as, hard, steel rail lines designed for train use. Specifically, a road or track for trains, consisting of parallel steel rails, supported on wooden crossbeams. The single track consists of one parallel sets of tracks.  


### DATA-SPECIFIC INFORMATION FOR: [/data/raw/OSM_LU01_LU13_LU15_LU21_VEG_2022.csv] 

*Information on exact methods for data extraction and more specific variable descriptions can be found on the [ABMI data archive wall to wall landcover inventory data download website for Year 2010](https://abmi.ca/home/data-analytics/da-top/da-product-overview/Data-Archive/Land-Cover.html)* **OR** *in the relevant_literature folder of this repository (LandcoverMapABMIGuide2010v1.0.pdf.pdf)*. 

* **Number of variables/columns:** 11
* **Number of observations/rows:** 3100 

**Variable List:**  

* <span style = "color: #2274A5;">**Site**</span>, a factor with 155 levels where the first element abbreviation describes the landscape unit (i.e. LU13, LU15, LU21, or LU01) and the second element describes the camera site.  

* <span style = "color: #2274A5;">**BUFF_DIST**</span>, a numeric measurement in meters ranging from 250 - 5000, of the buffer radius around the camera for which the proportion of associated human factors variables were calculated.  

* <span style = "color: #2274A5;">**LC_class20**</span>, a numeric variable indicating the proportion of landcover class 20 within the buffer area. Landcover class 20 is defined as water.   

* <span style = "color: #2274A5;">**LC_class33**</span>, a numeric variable indicating the proportion of landcover class 33 within the buffer area. Landcover class 33 is defined as exposed land.  

* <span style = "color: #2274A5;">**LC_class34**</span>, a numeric variable indicating the proportion of landcover class 34 within the buffer area. Landcover class 34 is defined as developed land.  

* <span style = "color: #2274A5;">**LC_class50**</span>, a numeric variable indicating the proportion of landcover class 50 within the buffer area. Landcover class 50 is defined as shrubland.  

* <span style = "color: #2274A5;">**LC_class110**</span>, a numeric variable indicating the proportion of landcover class 110 within the buffer area. Landcover class 110 is defined as grassland.  

* <span style = "color: #2274A5;">**LC_class120**</span>, a numeric variable indicating the proportion of landcover class 120 within the buffer area. Landcover class 120 is defined as agriculture.  

* <span style = "color: #2274A5;">**LC_class210**</span>, a numeric variable indicating the proportion of landcover class 210 within the buffer area. Landcover class 210 is defined as coniferous forest.  

* <span style = "color: #2274A5;">**LC_class220**</span>, a numeric variable indicating the proportion of landcover class 220 within the buffer area. Landcover class 220 is defined as broadleaf forest.

* <span style = "color: #2274A5;">**LC_class230**</span>, a numeric variable indicating the proportion of landcover class 230 within the buffer area. Landcover class 230 is defined as mixed forest.

