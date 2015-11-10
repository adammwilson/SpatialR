# Working With MODIS data




### Libraries


```r
library(raster)
library(rasterVis)
library(rgdal)
library(sp)
library(ggplot2)
library(ggmap)
library(dplyr)
library(reshape2)
library(knitr)
library(tidyr)

# New Packages
library(MODISTools)
library(gdalUtils)
library(rts)
```


## Specify directory to store data (absolute or relative to current working directory). 

```r
datadir="data"
```


## Working with _raw_ HDF files 

Will only work if your `gdal` was compiled with HDF support

```r
gdalinfo(formats = T) %>% grep(pattern="HDF",value=T)
```

```
## [1] "  HDF4 (ros): Hierarchical Data Format Release 4"
## [2] "  HDF4Image (rw+): HDF4 Dataset"                 
## [3] "  HDF5 (ros): Hierarchical Data Format Release 5"
## [4] "  HDF5Image (ro): HDF5 Dataset"
```


```r
hdf=file.path(datadir,"MCD12Q1.A2012001.h12v04.051.2014288200441_subset.hdf")
gdalinfo(hdf,nomd=T)
```

```
##  [1] "Driver: HDF4/Hierarchical Data Format Release 4"                                                                                               
##  [2] "Files: data/MCD12Q1.A2012001.h12v04.051.2014288200441_subset.hdf"                                                                              
##  [3] "Size is 512, 512"                                                                                                                              
##  [4] "Coordinate System is `'"                                                                                                                       
##  [5] "Subdatasets:"                                                                                                                                  
##  [6] "  SUBDATASET_1_NAME=HDF4_EOS:EOS_GRID:\"data/MCD12Q1.A2012001.h12v04.051.2014288200441_subset.hdf\":MOD12Q1:Land_Cover_Type_1"                 
##  [7] "  SUBDATASET_1_DESC=[2400x2400] Land_Cover_Type_1 MOD12Q1 (8-bit unsigned integer)"                                                            
##  [8] "  SUBDATASET_2_NAME=HDF4_EOS:EOS_GRID:\"data/MCD12Q1.A2012001.h12v04.051.2014288200441_subset.hdf\":MOD12Q1:Land_Cover_Type_1_Assessment"      
##  [9] "  SUBDATASET_2_DESC=[2400x2400] Land_Cover_Type_1_Assessment MOD12Q1 (8-bit unsigned integer)"                                                 
## [10] "  SUBDATASET_3_NAME=HDF4_EOS:EOS_GRID:\"data/MCD12Q1.A2012001.h12v04.051.2014288200441_subset.hdf\":MOD12Q1:Land_Cover_Type_QC.Num_QC_Words_01"
## [11] "  SUBDATASET_3_DESC=[2400x2400] Land_Cover_Type_QC.Num_QC_Words_01 MOD12Q1 (8-bit unsigned integer)"                                           
## [12] "Corner Coordinates:"                                                                                                                           
## [13] "Upper Left  (    0.0,    0.0)"                                                                                                                 
## [14] "Lower Left  (    0.0,  512.0)"                                                                                                                 
## [15] "Upper Right (  512.0,    0.0)"                                                                                                                 
## [16] "Lower Right (  512.0,  512.0)"                                                                                                                 
## [17] "Center      (  256.0,  256.0)"
```
More information available with `nomd=F`.

#### Translate to GEOtif

```r
gdal_translate("HDF4_EOS:EOS_GRID:\"data/MCD12Q1.A2012001.h12v04.051.2014288200441_subset.hdf\":MOD12Q1:Land_Cover_Type_1",
               "test.tif")
gdalinfo("test.tif",nomd=T)
```

#### Plot it


```r
d=raster("test.tif")
plot(d)
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-7-1.png) 

See also the `ModisDownload()` function in `library(rts)`:

* Downloads series of MODIS images in a specific timeframe for specified tile(s)
* MODIS Reproject Tool (MRT) software to mosaic, reproject, reformat

# Use MODISTools package to access the MODISweb

##  List MODIS products

```r
GetProducts()
```

```
##  [1] "MCD12Q1"    "MCD12Q2"    "MCD43A1"   
##  [4] "MCD43A2"    "MCD43A4"    "MOD09A1"   
##  [7] "MOD11A2"    "MOD13Q1"    "MOD15A2"   
## [10] "MOD15A2GFS" "MOD16A2"    "MOD17A2_51"
## [13] "MOD17A3"    "MYD09A1"    "MYD11A2"   
## [16] "MYD13Q1"    "MYD15A2"
```


```r
GetBands(Product = "MCD12Q1")
```

```
##  [1] "LC_Property_1"                      
##  [2] "LC_Property_2"                      
##  [3] "LC_Property_3"                      
##  [4] "Land_Cover_Type_1"                  
##  [5] "Land_Cover_Type_2"                  
##  [6] "Land_Cover_Type_3"                  
##  [7] "Land_Cover_Type_4"                  
##  [8] "Land_Cover_Type_5"                  
##  [9] "Land_Cover_Type_1_Assessment"       
## [10] "Land_Cover_Type_2_Assessment"       
## [11] "Land_Cover_Type_3_Assessment"       
## [12] "Land_Cover_Type_4_Assessment"       
## [13] "Land_Cover_Type_5_Assessment"       
## [14] "Land_Cover_Type_1_Secondary"        
## [15] "Land_Cover_Type_1_Secondary_Percent"
```

## Selection locations


```r
loc=rbind.data.frame(
  list("UB Spine",43.000753, -78.788195))
colnames(loc)=c("loc","lat","long")
coordinates(loc)=cbind(loc$long,loc$lat)
```

## Available dates

```r
mdates=GetDates(Product = "MOD11A2", Lat = loc$lat[1], Long = loc$long[1])
```

### MODIS date codes:

`.A2006001` - Julian Date of Acquisition (A-YYYYDDD)

Convert to a _proper_ date:

* Drop the "`A`"
* Specify date format with julian day `[1,365]`


```r
td=mdates[1:5]
td
```

```
## [1] "A2000065" "A2000073" "A2000081" "A2000089"
## [5] "A2000097"
```

`sub()` to _substitute_ a character in a `vector()`

```r
sub("A","",td)
```

```
## [1] "2000065" "2000073" "2000081" "2000089"
## [5] "2000097"
```

Check `?strptime` for date formats.

* `%Y` 4-digit year
* `%j` 3-digit Julian day


```r
sub("A","",td)%>%
  as.Date("%Y%j")
```

```
## [1] "2000-03-05" "2000-03-13" "2000-03-21"
## [4] "2000-03-29" "2000-04-06"
```

## Add start and end dates to `loc` object


```r
dates=mdates%>%sub(pattern="A",replacement="")%>%as.Date("%Y%j")

loc$start.date <- min(as.numeric(format(dates,"%Y")))
loc$end.date <- max(as.numeric(format(dates,"%Y")))
```

## Identify (and create) download folders

Today we'll work with:

* Land Surface Temperature (`lst`): MOD11A2
* Land Cover (`lc`): MCD12Q1


```r
lstdir=file.path(datadir,"lst")
if(!file.exists(lstdir)) dir.create(lstdir)

lcdir=file.path(datadir,"lc")
if(!file.exists(lcdir)) dir.create(lcdir)
```
##  Download subset

`Size`  whole km (integers) for each direction. 

`Size=c(1,1)` for 250m resolution data will return a 9x9 pixel tile for each location, centred on the input coordinate. 

`Size=c(0,0)` only the central pixel. 

**Maximum** size tile `Size=c(100,100)`

This can take a few minutes to run, so you can use the file provided in the data folder.  

### Get Land Surface Temperature Data

```r
MODISSubsets(LoadDat = loc,
             Products = c("MOD11A2"),
             Bands = c( "LST_Day_1km", "QC_Day"),
             Size = c(10,10),
             SaveDir=lstdir,
             StartDate=T)
```

### Get LULC

```r
MODISSubsets(LoadDat = loc,
             Products = c("MCD12Q1"),
             Bands = c( "Land_Cover_Type_1"),
             Size = c(10,10),
             SaveDir=lcdir,
             StartDate=T)
```

List available files:

```r
lst_files=list.files(lstdir,pattern="Lat.*asc",full=T)
head(lst_files)
```

```
## [1] "data/lst/Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2.asc"
```

Output:

* 1 file per location in `loc`
* Rows: time-steps
* Columns: data bands


```r
subset.string <- read.csv(lst_files[1],header = FALSE, as.is = TRUE)
dim(subset.string)
```

```
## [1] 1180  451
```

```r
subset.string[1:5,1:15]
```

```
##   V1 V2       V3      V4       V5
## 1 21 21 -6416881 4772121 926.6254
## 2 21 21 -6416881 4772121 926.6254
## 3 21 21 -6416881 4772121 926.6254
## 4 21 21 -6416881 4772121 926.6254
## 5 21 21 -6416881 4772121 926.6254
##                                                      V6
## 1 MOD11A2.A2001001.h12v04.005.2006350190920.LST_Day_1km
## 2 MOD11A2.A2001009.h12v04.005.2006352085909.LST_Day_1km
## 3 MOD11A2.A2001017.h12v04.005.2006354035616.LST_Day_1km
## 4 MOD11A2.A2001025.h12v04.005.2006355204922.LST_Day_1km
## 5 MOD11A2.A2001033.h12v04.005.2006357090922.LST_Day_1km
##        V7       V8
## 1 MOD11A2 A2001001
## 2 MOD11A2 A2001009
## 3 MOD11A2 A2001017
## 4 MOD11A2 A2001025
## 5 MOD11A2 A2001033
##                                      V9
## 1 Lat43.000753Lon-78.788195Samp21Line21
## 2 Lat43.000753Lon-78.788195Samp21Line21
## 3 Lat43.000753Lon-78.788195Samp21Line21
## 4 Lat43.000753Lon-78.788195Samp21Line21
## 5 Lat43.000753Lon-78.788195Samp21Line21
##            V10   V11   V12   V13   V14   V15
## 1 2.006350e+12 13321 13306 13296 13297 13314
## 2 2.006352e+12 13417 13407 13409 13400 13396
## 3 2.006354e+12 13388 13373 13395 13403 13400
## 4 2.006355e+12     0     0     0     0     0
## 5 2.006357e+12 13662     0     0     0     0
```

## Convert to ASCII Grid raster files

Use `MODISGrid()` to convert to separate [ASCII Grid format](http://resources.esri.com/help/9.3/arcgisdesktop/com/gp_toolref/spatial_analyst_tools/esri_ascii_raster_format.htm) files:

```
NCOLS xxx
NROWS xxx
XLLCENTER xxx | XLLCORNER xxx
YLLCENTER xxx | YLLCORNER xxx
CELLSIZE xxx
NODATA_VALUE xxx
row 1
row 2
...
row n
```

## Convert LST Data

```r
MODISGrid(Dir = lstdir, 
          DirName = "modgrid",
          SubDir = TRUE, 
          NoDataValues=
              list("MOD11A2" = c("LST_Day_1km" = 0,
                                 "QC_Day" = -1)))
```

## Convert LandCover Data

```r
MODISGrid(Dir = lcdir, 
          DirName = "modgrid",
          SubDir = TRUE, 
          NoDataValues=
              list("MCD12Q1" = c("Land_Cover_Type_1" = 255)))
```

## Get lists of `.asc` files


```r
lst_files=list.files(file.path(lstdir,"modgrid"),recursive=T,
                     pattern="LST_Day.*asc",full=T)
head(lst_files)
```

```
## [1] "data/lst/modgrid/Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2/GRID_Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2_LST_Day_1km_A2001001.asc"
## [2] "data/lst/modgrid/Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2/GRID_Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2_LST_Day_1km_A2001009.asc"
## [3] "data/lst/modgrid/Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2/GRID_Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2_LST_Day_1km_A2001017.asc"
## [4] "data/lst/modgrid/Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2/GRID_Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2_LST_Day_1km_A2001025.asc"
## [5] "data/lst/modgrid/Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2/GRID_Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2_LST_Day_1km_A2001033.asc"
## [6] "data/lst/modgrid/Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2/GRID_Lat43.00075Lon-78.78820Start2001-01-01End2013-12-31___MOD11A2_LST_Day_1km_A2001041.asc"
```

```r
lstqc_files=list.files(file.path(lstdir,"modgrid"),recursive=T,
                     pattern="QC_Day.*asc",full=T)
```

## Create raster stacks of evi and evi qc data

```r
lst=stack(lst_files)
plot(lst[[1:2]])
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-24-1.png) 

### Check gain and offset in [metadata](https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod11a2).


```r
gain(lst)=0.02
offs(lst)=-273.15
plot(lst[[1:2]])
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-25-1.png) 

# MODLAND Quality control

See a detailed explaination [here](https://lpdaac.usgs.gov/sites/default/files/public/modis/docs/MODIS_LP_QA_Tutorial-1b.pdf).  Some code below from [Steven Mosher's blog](https://stevemosher.wordpress.com/2012/12/05/modis-qc-bits/).

## MOD11A2 (Land Surface Temperature) Quality Control
[MOD11A2 QC Layer table](https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod11a2)

![](assets/lst_qc.png)


```r
lstqc=stack(lstqc_files)
plot(lstqc[[1:2]])
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-26-1.png) 

### LST QC data

QC data are encoded in 8-bit 'words' to compress information.


```r
values(lstqc[[1:2]])%>%table()
```

```
## .
##   0  17  65  81 
## 625   1 255   1
```


![](assets/QCdata.png)


```r
intToBits(65)
```

```
##  [1] 01 00 00 00 00 00 01 00 00 00 00 00 00 00 00
## [16] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
## [31] 00 00
```

```r
intToBits(65)[1:8]
```

```
## [1] 01 00 00 00 00 00 01 00
```

```r
as.integer(intToBits(65)[1:8])
```

```
## [1] 1 0 0 0 0 0 1 0
```
#### MODIS QC data are _Big Endian_

Format          Digits              value     sum
----            ----                ----      ----
Little Endian   1 0 0 0 0 0 1 0     65        2^0 + 2^6
Big Endian      0 1 0 0 0 0 0 1     65        2^6 + 2^0


Reverse the digits with `rev()` and compare with QC table above.


```r
rev(as.integer(intToBits(65)[1:8]))
```

```
## [1] 0 1 0 0 0 0 0 1
```
QC for value `65`:

* LST produced, other quality, recommend exampination of more detailed QA
* good data quality of L1B in 7 TIR bands
* average emissivity error <= 0.01
* Average LST error <= 2K

### Your turn
What does a QC value of 81 represent?

<br><br><br><br><br><br><br><br><br><br><br><br><br>



```r
rev(as.integer(intToBits(81)[1:8]))
```

```
## [1] 0 1 0 1 0 0 0 1
```

```r
# LST produced, other quality, recommend exampination of more detailed QA
# Other quality data
# Average emissivity error <= 0.01
# Average LST error <= 2K
```

### Filter the the lst data using the QC data


```r
## set up data frame to hold all combinations
QC_Data <- data.frame(Integer_Value = 0:255,
Bit7 = NA, Bit6 = NA, Bit5 = NA, Bit4 = NA,
Bit3 = NA, Bit2 = NA, Bit1 = NA, Bit0 = NA,
QA_word1 = NA, QA_word2 = NA, QA_word3 = NA,
QA_word4 = NA)

## 
for(i in QC_Data$Integer_Value){
AsInt <- as.integer(intToBits(i)[1:8])
QC_Data[i+1,2:9]<- AsInt[8:1]
}

QC_Data$QA_word1[QC_Data$Bit1 == 0 & QC_Data$Bit0==0] <- "LST GOOD"
QC_Data$QA_word1[QC_Data$Bit1 == 0 & QC_Data$Bit0==1] <- "LST Produced,Other Quality"
QC_Data$QA_word1[QC_Data$Bit1 == 1 & QC_Data$Bit0==0] <- "No Pixel,clouds"
QC_Data$QA_word1[QC_Data$Bit1 == 1 & QC_Data$Bit0==1] <- "No Pixel, Other QA"

QC_Data$QA_word2[QC_Data$Bit3 == 0 & QC_Data$Bit2==0] <- "Good Data"
QC_Data$QA_word2[QC_Data$Bit3 == 0 & QC_Data$Bit2==1] <- "Other Quality"
QC_Data$QA_word2[QC_Data$Bit3 == 1 & QC_Data$Bit2==0] <- "TBD"
QC_Data$QA_word2[QC_Data$Bit3 == 1 & QC_Data$Bit2==1] <- "TBD"

QC_Data$QA_word3[QC_Data$Bit5 == 0 & QC_Data$Bit4==0] <- "Emiss Error <= .01"
QC_Data$QA_word3[QC_Data$Bit5 == 0 & QC_Data$Bit4==1] <- "Emiss Err >.01 <=.02"
QC_Data$QA_word3[QC_Data$Bit5 == 1 & QC_Data$Bit4==0] <- "Emiss Err >.02 <=.04"
QC_Data$QA_word3[QC_Data$Bit5 == 1 & QC_Data$Bit4==1] <- "Emiss Err > .04"

QC_Data$QA_word4[QC_Data$Bit7 == 0 & QC_Data$Bit6==0] <- "LST Err <= 1"
QC_Data$QA_word4[QC_Data$Bit7 == 0 & QC_Data$Bit6==1] <- "LST Err > 2 LST Err <= 3"
QC_Data$QA_word4[QC_Data$Bit7 == 1 & QC_Data$Bit6==0] <- "LST Err > 1 LST Err <= 2"
QC_Data$QA_word4[QC_Data$Bit7 == 1 & QC_Data$Bit6==1] <- "LST Err > 4"
kable(head(QC_Data))
```



 Integer_Value   Bit7   Bit6   Bit5   Bit4   Bit3   Bit2   Bit1   Bit0  QA_word1                     QA_word2        QA_word3             QA_word4     
--------------  -----  -----  -----  -----  -----  -----  -----  -----  ---------------------------  --------------  -------------------  -------------
             0      0      0      0      0      0      0      0      0  LST GOOD                     Good Data       Emiss Error <= .01   LST Err <= 1 
             1      0      0      0      0      0      0      0      1  LST Produced,Other Quality   Good Data       Emiss Error <= .01   LST Err <= 1 
             2      0      0      0      0      0      0      1      0  No Pixel,clouds              Good Data       Emiss Error <= .01   LST Err <= 1 
             3      0      0      0      0      0      0      1      1  No Pixel, Other QA           Good Data       Emiss Error <= .01   LST Err <= 1 
             4      0      0      0      0      0      1      0      0  LST GOOD                     Other Quality   Emiss Error <= .01   LST Err <= 1 
             5      0      0      0      0      0      1      0      1  LST Produced,Other Quality   Other Quality   Emiss Error <= .01   LST Err <= 1 

### Select which QC Levels to keep

```r
keep=QC_Data[QC_Data$Bit1 == 0,]
keepvals=unique(keep$Integer_Value)
keepvals
```

```
##   [1]   0   1   4   5   8   9  12  13  16  17  20
##  [12]  21  24  25  28  29  32  33  36  37  40  41
##  [23]  44  45  48  49  52  53  56  57  60  61  64
##  [34]  65  68  69  72  73  76  77  80  81  84  85
##  [45]  88  89  92  93  96  97 100 101 104 105 108
##  [56] 109 112 113 116 117 120 121 124 125 128 129
##  [67] 132 133 136 137 140 141 144 145 148 149 152
##  [78] 153 156 157 160 161 164 165 168 169 172 173
##  [89] 176 177 180 181 184 185 188 189 192 193 196
## [100] 197 200 201 204 205 208 209 212 213 216 217
## [111] 220 221 224 225 228 229 232 233 236 237 240
## [122] 241 244 245 248 249 252 253
```

### How many observations will be dropped?


```r
qcvals=table(values(lstqc))  # this takes a minute or two


QC_Data%>%
  dplyr::select(everything(),-contains("Bit"))%>%
  mutate(Var1=as.character(Integer_Value),
         keep=Integer_Value%in%keepvals)%>%
  inner_join(data.frame(qcvals)) 
```

```
## Joining by: "Var1"
```

```
##   Integer_Value                   QA_word1
## 1             0                   LST GOOD
## 2             2            No Pixel,clouds
## 3            17 LST Produced,Other Quality
## 4            65 LST Produced,Other Quality
## 5            81 LST Produced,Other Quality
## 6           129 LST Produced,Other Quality
## 7           145 LST Produced,Other Quality
##    QA_word2             QA_word3
## 1 Good Data   Emiss Error <= .01
## 2 Good Data   Emiss Error <= .01
## 3 Good Data Emiss Err >.01 <=.02
## 4 Good Data   Emiss Error <= .01
## 5 Good Data Emiss Err >.01 <=.02
## 6 Good Data   Emiss Error <= .01
## 7 Good Data Emiss Err >.01 <=.02
##                   QA_word4 Var1  keep  Freq
## 1             LST Err <= 1    0  TRUE 62819
## 2             LST Err <= 1    2 FALSE 30750
## 3             LST Err <= 1   17  TRUE 11244
## 4 LST Err > 2 LST Err <= 3   65  TRUE 47211
## 5 LST Err > 2 LST Err <= 3   81  TRUE 99852
## 6 LST Err > 1 LST Err <= 2  129  TRUE     8
## 7 LST Err > 1 LST Err <= 2  145  TRUE  8306
```

Do you want to update the values you are keeping?

### Filter the LST Data keeping only `keepvals`

These steps take a couple minutes.  


```r
## Make logical flag for mask
lstkeep=calc(lstqc,function(x) x%in%keepvals)
plot(lstkeep)
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-34-1.png) 

```r
## Mask the lst data using the QC data
lst2=mask(lst,mask=lstkeep,maskval=0)
```


## Add Dates to Z dimension


```r
tdates=names(lst)%>%
  sub(pattern=".*_A",replacement="")%>%
  as.Date("%Y%j")

names(lst2)=1:nlayers(lst2)
lst2=setZ(lst2,tdates)
```

## Summarize to Seasonal climatologies

Use `stackApply()` with a seasonal index.


```r
tseas=as.numeric(sub("Q","",quarters(getZ(lst2))))
tseas[1:20]
```

```
##  [1] 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2
```

```r
lst_seas=stackApply(lst2,indices = tseas,mean,na.rm=T)
names(lst_seas)=c("1_Winter","2_Spring","3_Summer","4_Fall")

gplot(lst_seas)+geom_raster(aes(fill=value))+
  facet_wrap(~variable)+
  scale_fill_gradientn(colours=c("blue",mid="grey","red"))+
  coord_equal()
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-36-1.png) 

## Your turn:

Use `stackApply()` to generate and plot monthly median lst values.

<br><br><br><br><br><br><br><br><br><br><br><br><br>


```r
tmonth=as.numeric(format(getZ(lst2),"%m"))

lst_month=stackApply(lst2,indices = tmonth,mean,na.rm=T)
names(lst_month)=sprintf("%02d",1:12)

gplot(lst_month)+geom_raster(aes(fill=value))+
  facet_wrap(~variable)+
  scale_fill_gradientn(colours=c("blue",mid="grey","red"))+
  coord_equal()
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-37-1.png) 

## Extract timeseries for a point


```r
lw=SpatialPoints(data.frame(x= -78.791547,y=43.007211))
projection(lw)="+proj=longlat"
lw=spTransform(lw,projection(lst2))

lwt=data.frame(date=getZ(lst2),
                 lst=t(raster::extract(lst2,lw,buffer=1000,fun=mean,na.rm=T)))

ggplot(lwt,aes(x=date,y=lst))+
  geom_path()
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-38-1.png) 

See the `library(rts)` for more timeseries related functions.

### Process landcover data

```r
lc_files=list.files(file.path(lcdir,"modgrid"),recursive=T,
                     pattern="Land_Cover_Type_1.*asc",full=T)
lc=raster(lc_files[1])
```

Get cover clases from [MODIS website](https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mcd12q1)


```r
  Land_Cover_Type_1 = c(
    Water = 0, 
    `Evergreen Needleleaf forest` = 1, 
    `Evergreen Broadleaf forest` = 2,
    `Deciduous Needleleaf forest` = 3, 
    `Deciduous Broadleaf forest` = 4,
    `Mixed forest` = 5, 
    `Closed shrublands` = 6,
    `Open shrublands` = 7,
    `Woody savannas` = 8, 
    Savannas = 9,
    Grasslands = 10,
    `Permanent wetlands` = 11, 
    Croplands = 12,
    `Urban & built-up` = 13,
    `Cropland/Natural vegetation mosaic` = 14, 
    `Snow & ice` = 15,
    `Barren/Sparsely vegetated` = 16, 
    Unclassified = 254,
    NoDataFill = 255)
```

Convert to `factor` raster

```r
lc=ratify(lc)
levels(lc)=data.frame(ID=Land_Cover_Type_1,landcover=names(Land_Cover_Type_1))
```

```
## Warning in .checkLevels(levels(x)[[1]], value):
## the number of rows in the raster attributes
## (factors) data.frame is unexpected
```

```
## Warning in sort(newv[, 1]) == sort(old[, 1]):
## longer object length is not a multiple of shorter
## object length
```

```
## Warning in .checkLevels(levels(x)[[1]], value):
## the values in the "ID" column in the raster
## attributes (factors) data.frame have changed
```
Warnings OK because some factors not present in this subset...

### Resample `lc` to `lst` grid


```r
lc2=resample(lc,lst,method="ngb")
plot(lc)
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-42-1.png) 

```r
plot(lc2)
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-42-2.png) 

### Summarize mean monthly temperatures by Landcover


```r
table(values(lc))
```

```
## 
##   0   1   3   4   5   6   8   9  10  11  12  13 
##  17  21   2  53  14   2  43   6   1   8  72 787 
##  14 
## 655
```

### Use Zonal Statistics to calculate summaries

```r
lct.mean=zonal(lst_seas,lc2,'mean',na.rm=T)%>%data.frame()
lct.sd=zonal(lst_seas,lc2,'sd',na.rm=T)%>%data.frame()
lct.count=zonal(lst_seas,lc2,'count',na.rm=T)%>%data.frame()

lct.summary=rbind(data.frame(lct.mean,var="mean"),
                  data.frame(lct.sd,var="sd"),
                  data.frame(lct.count,var="count"))
```

#### Summarize for plotting

```r
lctl=melt(lct.summary,id.var=c("zone","var"),value="lst")
lctl$season=factor(lctl$variable,labels=c("Winter","Spring","Summer","Fall"),ordered=T)
lctl$lc=levels(lc)[[1]][lctl$zone+1,"landcover"]
lctl=dcast(lctl,zone+season+lc~var,value="value")
head(lctl)
```

```
##   zone season                          lc
## 1    0 Winter                       Water
## 2    0 Spring                       Water
## 3    0 Summer                       Water
## 4    0   Fall                       Water
## 5    1 Winter Evergreen Needleleaf forest
## 6    1 Spring Evergreen Needleleaf forest
##         mean        sd count
## 1  0.5153696 0.3662726     5
## 2 17.5434186 1.2999543     5
## 3 22.9897867 0.6123666     5
## 4  7.7698341 0.5391288     5
## 5  0.7437689 0.5203108     6
## 6 19.4351263 2.3721006     6
```

#### Plot it

```r
ggplot(lctl,aes(x=season,y=mean,group=lc,colour=lc))+
  geom_line()+
  geom_errorbar(aes(ymax=mean+sd,ymin=mean-sd))
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-46-1.png) 

## Keep only common LC types (>10 pixels)

```r
ggplot(filter(lctl,count>=10),
       aes(x=season,y=mean,group=lc,colour=lc,
           ymax=mean+sd,ymin=mean-sd))+
  geom_pointrange(position="jitter")
```

![](10_RemoteSensing_exercise_files/figure-html/unnamed-chunk-47-1.png) 

## Your turn

Calculate the  maximum observed seasonal average lst in each land cover type.  

<br><br><br><br><br><br><br><br><br><br><br><br><br>


```r
zonal(max(lst_seas),lc2,'max',na.rm=T)%>%data.frame()%>%
  left_join(levels(lc)[[1]],by=c("zone"="ID"))%>%
  arrange(max)
```

```
##    zone      max
## 1     0 23.94775
## 2     1 24.88800
## 3     3 25.15752
## 4     5 25.68387
## 5     4 26.23543
## 6     8 26.87503
## 7     9 29.84034
## 8    12 31.04633
## 9    14 31.36159
## 10   13 31.63883
##                             landcover
## 1                               Water
## 2         Evergreen Needleleaf forest
## 3         Deciduous Needleleaf forest
## 4                        Mixed forest
## 5          Deciduous Broadleaf forest
## 6                      Woody savannas
## 7                            Savannas
## 8                           Croplands
## 9  Cropland/Natural vegetation mosaic
## 10                   Urban & built-up
```


