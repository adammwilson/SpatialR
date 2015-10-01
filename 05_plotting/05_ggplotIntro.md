# Introduction to ggplot2
Adam M. Wilson  
September 2015  



## [`ggplot2`](http://ggplot2.org)
The _grammar of graphics_:  consistent aesthetics, multidimensional conditioning, and step-by-step plot building.

* **dataset** with mappings from variables to aesthetics
* one or more **layers**
* one **scale** for each aesthetic mapping
* a **coordinate** system,
* the **facet** specification (conditioning)


```r
library(ggplot2)
```

---

<img src="assets/ggplot_intro1.png" alt="alt text" width="100%">

---

<img src="assets/ggplot_intro2.png" alt="alt text" width="100%">


```r
p <- ggplot(mpg, aes(x=hwy, y=cty))
p + geom_point()
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-3-1.png) 

---

<img src="assets/ggplotSyntax.png" alt="alt text" width="90%">

## Simple scatterplot


```r
p <- ggplot(mtcars, aes(x=wt, y=mpg))
p + geom_point()
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-4-1.png) 

## Add aesthetic mappings

### Set color by # of cylinders

```r
p + geom_point(aes(colour = factor(cyl)))
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-5-1.png) 

---

### Set shape using # of cylinders 

```r
p + geom_point(aes(shape = factor(cyl)))
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-6-1.png) 

---

### Adjust size by `qsec` 

```r
p + geom_point(aes(size = qsec))
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-7-1.png) 

---

### Add a linear model

```r
p + geom_point() + geom_smooth(method="lm")
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-8-1.png) 

---

### Change scale color


```r
p + geom_point(aes(colour = cyl)) + scale_colour_gradient(low = "blue")
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-9-1.png) 

---

### Change scale shapes


```r
p + geom_point(aes(shape = factor(cyl))) + scale_shape(solid = FALSE)
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-10-1.png) 

---

### Set aesthetics to fixed value

```r
ggplot(mtcars, aes(wt, mpg)) + geom_point(colour = "red", size = 3)
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-11-1.png) 


## Transparancy
Varying alpha is useful for large datasets

```r
d <- ggplot(diamonds, aes(carat, price))
d + geom_point(alpha = 1/10)
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-12-1.png) 

---


```r
d + geom_point(alpha = 1/20)
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-13-1.png) 

--- 


```r
d + geom_point(alpha = 1/100)
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-14-1.png) 

## Other Plot types

---

<img src="assets/ggplot01.png" alt="alt text" width="70%">

---

<img src="assets/ggplot02.png" alt="alt text" width="100%">

---

<img src="assets/ggplot03.png" alt="alt text" width="70%">

---

<img src="assets/ggplot05.png" alt="alt text" width="80%">

---

<img src="assets/ggplot06.png" alt="alt text" width="100%">

---

### Three Variables
<img src="assets/ggplot07.png" alt="alt text" width="100%">

---

### Stats
Visualize a data transformation

<img src="assets/ggplotStat01.png" alt="alt text" width="100%">

* Each stat creates additional variables with a common ``..name..`` syntax
* Often two ways: `stat_bin(geom="bar")`  OR  `geom_bar(stat="bin")`

---

<img src="assets/ggplotStat02.png" alt="alt text" width="100%">

---

<img src="assets/ggplotStat03.png" alt="alt text" width="80%">

## Specifying Scales

<img src="assets/ggplotScales01.png" alt="alt text" width="100%">

---

### Discrete color: default


```r
b=ggplot(mpg,aes(fl))+geom_bar( aes(fill = fl)); b
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-15-1.png) 

---

### Discrete color: brewer


```r
b+scale_fill_brewer( palette = "Blues")
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-16-1.png) 


---

### Discrete color: greys


```r
b+scale_fill_grey( start = 0.2, end = 0.8, na.value = "red")
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-17-1.png) 

---

### Continuous color: defaults


```r
a <- ggplot(mpg, aes(hwy)) + geom_dotplot( aes(fill = ..x..)); a
```

```
## stat_bindot: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-18-1.png) 

---

### Continuous color: `gradient`


```r
a + scale_fill_gradient( low = "red", high = "yellow")
```

```
## stat_bindot: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-19-1.png) 

---

### Continuous color: `gradient2`


```r
a + scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 25)
```

```
## stat_bindot: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-20-1.png) 

---

### Continuous color: `gradientn`


```r
a + scale_fill_gradientn( colours = rainbow(10))
```

```
## stat_bindot: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![](05_ggplotIntro_files/figure-html/unnamed-chunk-21-1.png) 

## Coordinate Systems

<img src="assets/ggplotCoords.png" alt="alt text" width="55%">

## Position

<img src="assets/ggplotPosition.png" alt="alt text" width="80%">



## Themes

<img src="assets/ggplotThemes.png" alt="alt text" width="80%">


## Colophon

Sources:
*  [ggplot cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)
* 

Licensing: 
* Presentation: [CC-BY-3.0 ](http://creativecommons.org/licenses/by/3.0/us/)
* Source code: [MIT](http://opensource.org/licenses/MIT) 

