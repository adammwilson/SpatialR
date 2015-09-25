#' ---
#' title: "Reproducible Research II"
#' author: "Adam M. Wilson"
#' date: "September 2015"
#' output:
#'   html_document:
#'       keep_md: true
#' ---
#' 
#' 
#' Load these packages in a code chunk:
#' 
## ---- message=F----------------------------------------------------------
library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)
library(spocc)

#' 
#' 
#' # Download data
#' 
#' ## Daily ozone data from the EPA
#' The data are available from 1990 through 2015, but for now we'll just use 2013:2014.  If you want to extend the analysis, feel free to change this.  
## ------------------------------------------------------------------------
years=2013:2014

files=paste0("http://aqsdr1.epa.gov/aqsweb/aqstmp/airdata/daily_44201_",years,".zip")

files

#' 
#' ### Create a directory to hold the data.
## ------------------------------------------------------------------------
datadir="data"

#' 
#' ### Write a simple download function
#' 
#' 1. Checks if file already exists
#' 2. If needed, downloads the file.
#' 3. Unzips the file into our `datadir`
#' 
## ------------------------------------------------------------------------
downloadData=function(file,overwrite=F){
  cfile=sub("zip","csv",file)%>%basename()  #get filename
  if(file.exists(file.path(datadir,cfile))) {
    return("File exists")
  }
  temp <- tempfile()  # make a filename for a temporary file
  download.file(file,temp)  # download the zipped file from the website
  unzip(temp,exdir=datadir)  # unzip the data to our datadir
  file.remove(temp)  # remove the zipped file
}

#'   
#' 
#' Try running that for just one year:
## ------------------------------------------------------------------------
downloadData(files[1])

#' 
#' ### Download all desired years with a simple `for()` loop
#' 
## ------------------------------------------------------------------------
for(f in files){
  downloadData(f)
}

#' 
#' 
#' ## Load Data
#' 
#' ### Another function to load all available datasets
## ------------------------------------------------------------------------
loadData <- function(path) { 
  files <- dir(path, pattern = '\\.csv', full.names = TRUE)
  tables <- lapply(files, read.csv, stringsAsFactors=F)
  dplyr::bind_rows(tables)
}

#' 
#' > Use two colons (`::`) to call a function from a package without explicitly loading the package.
#' 
#' ### Import the data
#' 
## ------------------------------------------------------------------------
d=loadData(datadir)

d

#' 
#' 
## ------------------------------------------------------------------------
d%>%
  separate(col=Date.Local,into=c("year","month","day"),sep="-")%>%
  group_by(Latitude,Longitude,year)%>%
  summarise(mean=mean(Arithmetic.Mean,na.rm=T))

#' 
#' 
#' ## Get polygon layer of states
## ------------------------------------------------------------------------
usa=map("state")

d%>%filter(State.Name=="New York")%>%
  select(Latitude, Longitude, County.Name, Address)%>% distinct()


#' 
#' ## Step 2: Load data
#' 
#' 
## ------------------------------------------------------------------------
## define which species to query
sp='Turdus migratorius'


#' This can take a few seconds.
#' 
#' ## Step 3: Map it
#' 
## ---- fig.width=6--------------------------------------------------------
# Load coastline
map=map_data("world")

#ggplot(d,aes(x=longitude,y=latitude))+
##  geom_polygon(aes(x=long,y=lat,group=group,order=order),data=map)+
#  geom_point(col="red")+
#  coord_equal()

#' 
#' 
#' ## Step 6:  Explore markdown functions
#' 
#' 1. Use the Cheatsheet to add sections and some example narrative.  
#' 2. Try changing changing the species name to your favorite species and re-run the report.  
#' 3. Stage, Commit, Push!
#' 4. Explore the markdown file on the GitHub website.  
#' 
#' 
#' ## Colophon
#' 
#' Licensing: 
#' * Presentation: [CC-BY-3.0 ](http://creativecommons.org/licenses/by/3.0/us/)
#' * Source code: [MIT](http://opensource.org/licenses/MIT) 
#' 
#' 
#' ## References
#' 
#' See Rmd file for full references and sources
