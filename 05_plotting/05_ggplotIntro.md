# Introduction to ggplot2
Adam M. Wilson  
October 2015  



## Today

1. `ggplot` graphics
2. spatial (vector) data with `sp` package

## [`ggplot2`](http://ggplot2.org)
The _grammar of graphics_:  consistent aesthetics, multidimensional conditioning, and step-by-step plot building.


1.	Data: 		The raw data
2.	`geom_`: The geometric shapes representing data
3.	`aes()`:	Aesthetics of the geometric and statistical objects (color, size, shape, and position)
4.	`scale_`:	Maps between the data and the aesthetic dimensions

```
data
+ geometry,
+ aesthetic mappings like position, color and size
+ scaling of ranges of the data to ranges of the aesthetics
```

---

### Additional settings

5.	`stat_`:	Statistical summaries of the data that can be plotted, such as quantiles, fitted curves (loess, linear models), etc.
6.	`coord_`:	Transformation for mapping data coordinates into the plane of the data rectangle
7.	`facet_`:	Arrangement of data into grid of plots
8.	`theme`:	Visual defaults (background, grids, axes, typeface, colors, etc.)


---

<img src="assets/ggplot_intro1.png" alt="alt text" width="100%">


---

<img src="assets/ggplot_intro2.png" alt="alt text" width="100%">

## Simple scatterplot


```r
library(ggplot2)
p <- ggplot(mtcars, aes(x=wt, y=mpg))
p + geom_point()
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-2-1.png) 

---

### Aesthetic map: color by # of cylinders


```r
p + 
  geom_point(aes(colour = factor(cyl)))
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-3-1.png) 

---

### Set shape using # of cylinders 

```r
p + 
  geom_point(aes(shape = factor(cyl)))
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-4-1.png) 

---

### Adjust size by `qsec` 

```r
p + 
  geom_point(aes(size = qsec))
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-5-1.png) 

---

### Color by cylinders and size by `qsec` 

```r
p + 
  geom_point(aes(colour = factor(cyl),size = qsec))
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-6-1.png) 

---

### Multiple aesthetics

```r
p + 
  geom_point(aes(colour = factor(cyl),size = qsec,shape=factor(gear)))
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-7-1.png) 

---

### Add a linear model

```r
p + geom_point() + 
  geom_smooth(method="lm")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-8-1.png) 

---

### Change scale color


```r
p + geom_point(aes(colour = cyl)) + 
  scale_colour_gradient(low = "blue")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-9-1.png) 

---

### Change scale shapes


```r
p + geom_point(aes(shape = factor(cyl))) + 
  scale_shape(solid = FALSE)
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-10-1.png) 

---

### Set aesthetics to fixed value

```r
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point(colour = "red", size = 3)
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-11-1.png) 

---

### Transparancy: alpha=0.2

```r
d <- ggplot(diamonds, aes(carat, price))
d + geom_point(alpha = 0.2)
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-12-1.png) 

Varying alpha useful for large data sets

---

### Transparancy: alpha=0.1


```r
d + 
  geom_point(alpha = 0.1)
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-13-1.png) 

--- 

### Transparancy: alpha=0.01


```r
d + 
  geom_point(alpha = 0.01)
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-14-1.png) 


## Building ggplots

<img src="assets/ggplotSyntax.png" alt="alt text" width="90%">

## Other Plot types

---

<img src="assets/ggplot01.png" alt="alt text" width="70%">

---

## Your turn

Edit plot `p` above to include:

1. points
2. A smooth ('loess') curve
3. a "rug" to the plot

---


```r
p+
  geom_point()+
  geom_smooth()+
  geom_rug()
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-15-1.png) 

---

<img src="assets/ggplot02.png" alt="alt text" width="100%">

---

<img src="assets/ggplot03.png" alt="alt text" width="70%">

---

<img src="assets/ggplot05.png" alt="alt text" width="80%">

---

### Discrete X, Continuous Y


```r
p <- ggplot(mtcars, aes(factor(cyl), mpg))
p + geom_point()
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-16-1.png) 

---

### Discrete X, Continuous Y + geom_jitter()


```r
p + 
  geom_jitter()
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-17-1.png) 

---

### Discrete X, Continuous Y + geom_violin()


```r
p + 
  geom_violin()
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-18-1.png) 

---

### Discrete X, Continuous Y + geom_violin()


```r
p + 
  geom_violin() + geom_jitter(position = position_jitter(width = .1))
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-19-1.png) 

---

<img src="assets/ggplot06.png" alt="alt text" width="100%">

---

### Three Variables
<img src="assets/ggplot07.png" alt="alt text" width="120%">

Will come back to this next week for raster package.

---

### Stats
Visualize a data transformation

<img src="assets/ggplotStat01.png" alt="alt text" width="100%">

* Each stat creates additional variables with a common ``..name..`` syntax
* Often two ways: `stat_bin(geom="bar")`  OR  `geom_bar(stat="bin")`

---

<img src="assets/ggplotStat02.png" alt="alt text" width="100%">

---

### 2D kernel density estimation

Old Faithful Geyser Data on duration and waiting times.


```r
library("MASS")
data(geyser)
m <- ggplot(geyser, aes(x = duration, y = waiting))
```

<img src="assets/Old_Faithful.jpg" alt="alt text" width="50%"> <small>[photo: Greg Willis](https://commons.wikimedia.org/wiki/File:Old_Faithful_(3679482556).jpg)</small>

See `?geyser` for details.

---


```r
m + 
  geom_point()
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-21-1.png) 

---


```r
m + 
  geom_point() +  stat_density2d(geom="contour")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-22-1.png) 

Check `?geom_density2d()` for details

---


```r
m + 
  geom_point() +  stat_density2d(geom="contour") +
  xlim(0.5, 6) + ylim(40, 110)
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-23-1.png) 

Update limits to show full contours.  Check `?geom_density2d()` for details


---


```r
m + stat_density2d(aes(fill = ..level..), geom="polygon") + 
  geom_point(col="red")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-24-1.png) 

Check `?geom_density2d()` for details

---

<img src="assets/ggplotStat03.png" alt="alt text" width="80%">

---

## Your turn

Edit plot `m` to include: 

* The point data (with red points) on top
* A `binhex` plot of the Old Faithful data

Experiment with the number of bins to find one that works.  

See `?stat_binhex` for details

---


```r
m + stat_binhex(bins=10) + 
  geom_point(col="red")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-25-1.png) 


## Specifying Scales

<img src="assets/ggplotScales01.png" alt="alt text" width="100%">

---

### Discrete color: default


```r
b=ggplot(mpg,aes(fl))+
  geom_bar( aes(fill = fl)); b
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-26-1.png) 


---

### Discrete color: greys


```r
b + scale_fill_grey( start = 0.2, end = 0.8, 
                   na.value = "red")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-27-1.png) 

---

### Continuous color: defaults


```r
a <- ggplot(mpg, aes(hwy)) + 
  geom_dotplot( aes(fill = ..x..)); a
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-28-1.png) 

---

### Continuous color: `gradient`


```r
a +  scale_fill_gradient( low = "red", 
                          high = "yellow")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-29-1.png) 

---

### Continuous color: `gradient2`


```r
a + scale_fill_gradient2(low = "red", high = "blue", 
                       mid = "white", midpoint = 25)
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-30-1.png) 

---

### Continuous color: `gradientn`


```r
a + scale_fill_gradientn(
  colours = rainbow(10))
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-31-1.png) 

---

### Discrete color: brewer


```r
b + 
  scale_fill_brewer( palette = "Blues")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-32-1.png) 

## [colorbrewer2.org](http://colorbrewer2.org)


<img src="assets/brewer1.png" alt="alt text" width="100%">

---

## ColorBrewer: Diverging

<img src="assets/brewer2.png" alt="alt text" width="100%">

## ColorBrewer: Filtered

<img src="assets/brewer3.png" alt="alt text" width="100%">


## Your turn

Edit the contour plot of the geyser data to use a sequential brewer palette: 


```r
m +
  stat_density2d(aes(fill = ..level..), geom="polygon") + 
  geom_point(col="red")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-33-1.png) 

Note: use`scale_fill_distiller()` rather than `scale_fill_brewer()` for continuous data

---


```r
m + stat_density2d(aes(fill = ..level..), geom="polygon") + 
  geom_point(size=.75)+
  scale_fill_distiller(palette="OrRd",#breaks=c(0.005,0.008,0.01),
                       name="Kernel\nDensity")+
      xlim(0.5, 6) + ylim(40, 110)+
  xlab("Eruption Duration (minutes)")+
  ylab("Waiting time (minutes)")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-34-1.png) 

---

Or use `geom=tile` for a raster representation.


```r
m + stat_density2d(aes(fill = ..density..), geom="tile",contour=F) + 
  geom_point(size=.75)+
  scale_fill_distiller(palette="OrRd",
                       name="Kernel\nDensity")+
      xlim(0.5, 6) + ylim(40, 110)+
  xlab("Eruption Duration (minutes)")+
  ylab("Waiting time (minutes)")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-35-1.png) 


---

## Axis scaling


Create noisy exponential data


```r
set.seed(201)
n <- 100
dat <- data.frame(
    xval = (1:n+rnorm(n,sd=5))/20,
    yval = 10^((1:n+rnorm(n,sd=5))/20)
)
```

---

Make scatter plot with regular (linear) axis scaling

```r
sp <- ggplot(dat, aes(xval, yval)) + geom_point()
sp
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-37-1.png) 

<small> Example from [R Cookbook](http://www.cookbook-r.com/Graphs/Axes_(ggplot2)/) </small>

---

log10 scaling of the y axis (with visually-equal spacing)


```r
sp + scale_y_log10()
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-38-1.png) 

## Coordinate Systems

<img src="assets/ggplotCoords.png" alt="alt text" width="55%">


## Position

<img src="assets/ggplotPosition.png" alt="alt text" width="80%">

---

### Stacked bars


```r
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar()
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-39-1.png) 

---

### Dodged bars



```r
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar(position="dodge")
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-40-1.png) 

# Example Graphics from the NY Times

---

### Baseball performance
<img src="assets/baseball.png" alt="alt text" width="75%">
<small>[NY Times](http://www.nytimes.com/interactive/2012/05/05/sports/baseball/mariano-rivera-and-his-peers.html?ref=baseball&_r=0)</small>

---

### Wealthiest 1%
<img src="assets/wealthy.jpg" alt="alt text" width="80%">
<small>[NY Times](http://www.nytimes.com/interactive/2012/01/15/business/one-percent-map.html?ref=business)</small>

---

### Donors visit the White House
<img src="assets/donors.png" alt="alt text" width="50%">
<small>[NY Times](http://www.nytimes.com/interactive/2012/04/15/us/politics/Access-in-Washington-Rises-With-Donation-Size.html?ref=politics)</small>


# Themes


## GGplot Themes

<img src="assets/ggplotThemes.png" alt="alt text" width="80%">

Quickly change plot appearance with themes.

### More options in the `ggthemes` package.

```r
library(ggthemes)
```

Or build your own!

---

### Theme examples: default

```r
p=ggplot(mpg, aes(x = cty, y = hwy, color = factor(cyl))) +
  geom_jitter() +
  labs(
    x = "City mileage/gallon",
    y = "Highway mileage/gallon",
    color = "Cylinders"
  )
```

---

### Theme examples: default

```r
p
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-43-1.png) 

--- 

### Theme examples: Solarized

```r
p + theme_solarized()
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-44-1.png) 

--- 

### Theme examples: Solarized Dark

```r
p +  theme_solarized(light=FALSE)
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-45-1.png) 

--- 

### Theme examples: Excel

```r
p + theme_excel() 
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-46-1.png) 

--- 

### Theme examples: _The Economist_

```r
p + theme_economist()
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-47-1.png) 

# Faceting

## _Faceting_ 

`facet_wrap()`: one variable


```r
ggplot(mpg, aes(x = cty, y = hwy, color = factor(cyl))) +
  geom_jitter()+
  facet_wrap(~year)
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-48-1.png) 

---

`facet_grid()`: two variables


```r
ggplot(mpg, aes(x = cty, y = hwy, color = factor(cyl))) +
  geom_jitter()+
  facet_grid(year~cyl)
```

![](05_ggplotIntro_files/figure-revealjs/unnamed-chunk-49-1.png) 

Very useful for timeseries of spatial data.


# Saving/exporting

## Saving using the GUI
<img src="assets/ggplot_guisave.png" alt="alt text" width="80%">

---


## Saving using `ggsave()`
Save a `ggplot` with sensible defaults:

```r
ggsave(filename, plot = last_plot(), scale = 1, width, height)
```

---

## Saving using devices

Save any plot with maximum flexibility:


```r
pdf(filename, width, height)  # open device
ggplot()                      # draw the plot(s)
dev.off()                     # close the device
```

**Formats**

* pdf
* jpeg
* png
* tif

and more...

---

## Your turn: save a plot

1. Save the `p` plot from above using `png()` and `dev.off()`
2. Switch to the solarized theme with `light=FALSE`
2. Adjust fontsize with `base_size` in the theme `+ theme_solarized(base_size=24)`

## Save a plot: Example 1


```r
png("assets/test1.png",width=600,height=300)
p +  theme_solarized(light=FALSE)
dev.off()
```

```
## quartz_off_screen 
##                 2
```
<img src="assets/test1.png" alt="alt text" width="80%">

## Save a plot: Example 2


```r
png("assets/test2.png",width=600,height=300)
p +  theme_solarized(light=FALSE, base_size=24)
dev.off()
```

```
## quartz_off_screen 
##                 2
```
<img src="assets/test2.png" alt="alt text" width="80%">


## GGPLOT2 Documentation

Perhaps R's best documented package: [docs.ggplot2.org](http://docs.ggplot2.org/current/)

<img src="assets/ggplotDoc.png" alt="alt text" width="100%">

## Colophon

Sources:

*  [ggplot cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)

Licensing: 

* Presentation: [CC-BY-3.0 ](http://creativecommons.org/licenses/by/3.0/us/)
* Source code: [MIT](http://opensource.org/licenses/MIT) 

