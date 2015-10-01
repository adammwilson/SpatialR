#' ---
#' title: "Introduction to ggplot2"
#' author: "Adam M. Wilson"
#' date: "September 2015"
#' output: 
#'   revealjs::revealjs_presentation:
#'       theme: sky
#'       transition: fade
#'       highlight: monochrome
#'       center: true
#'       width: 1080
#'       widgets: [mathjax, bootstrap,rCharts]
#'       keep_md:  true
#'       pandoc_args: [ "--slide-level", "2" ]
#'   html_document:
#'     keep_md: true
#' 
#' ---
#' 
#' 
#' ## [`ggplot2`](http://ggplot2.org)
#' The _grammar of graphics_:  consistent aesthetics, multidimensional conditioning, and step-by-step plot building.
#' 
#' * **dataset** with mappings from variables to aesthetics
#' * one or more **layers**
#' * one **scale** for each aesthetic mapping
#' * a **coordinate** system,
#' * the **facet** specification (conditioning)
#' 
## ------------------------------------------------------------------------
library(ggplot2)

#' 
#' ---
#' 
#' <img src="assets/ggplot_intro1.png" alt="alt text" width="100%">
#' 
#' ---
#' 
#' <img src="assets/ggplot_intro2.png" alt="alt text" width="100%">
#' 
## ----fig.width=7,fig.height=3--------------------------------------------
p <- ggplot(mpg, aes(x=hwy, y=cty))
p + geom_point()

#' 
#' ---
#' 
#' <img src="assets/ggplotSyntax.png" alt="alt text" width="90%">
#' 
#' ## Simple scatterplot
#' 
## ------------------------------------------------------------------------
p <- ggplot(mtcars, aes(x=wt, y=mpg))
p + geom_point()

#' 
#' ## Add aesthetic mappings
#' 
#' ### Set color by # of cylinders
## ------------------------------------------------------------------------
p + geom_point(aes(colour = factor(cyl)))

#' 
#' ---
#' 
#' ### Set shape using # of cylinders 
## ------------------------------------------------------------------------
p + geom_point(aes(shape = factor(cyl)))

#' 
#' ---
#' 
#' ### Adjust size by `qsec` 
## ------------------------------------------------------------------------
p + geom_point(aes(size = qsec))

#' 
#' ---
#' 
#' ### Add a linear model
## ------------------------------------------------------------------------
p + geom_point() + geom_smooth(method="lm")

#' 
#' ---
#' 
#' ### Change scale color
#' 
## ------------------------------------------------------------------------
p + geom_point(aes(colour = cyl)) + scale_colour_gradient(low = "blue")

#' 
#' ---
#' 
#' ### Change scale shapes
#' 
## ------------------------------------------------------------------------
p + geom_point(aes(shape = factor(cyl))) + scale_shape(solid = FALSE)

#' 
#' ---
#' 
#' ### Set aesthetics to fixed value
## ------------------------------------------------------------------------
ggplot(mtcars, aes(wt, mpg)) + geom_point(colour = "red", size = 3)

#' 
#' 
#' ## Transparancy
#' Varying alpha is useful for large datasets
## ------------------------------------------------------------------------
d <- ggplot(diamonds, aes(carat, price))
d + geom_point(alpha = 1/10)

#' 
#' ---
#' 
## ------------------------------------------------------------------------
d + geom_point(alpha = 1/20)

#' 
#' --- 
#' 
## ------------------------------------------------------------------------
d + geom_point(alpha = 1/100)

#' 
#' ## Other Plot types
#' 
#' ---
#' 
#' <img src="assets/ggplot01.png" alt="alt text" width="70%">
#' 
#' ---
#' 
#' <img src="assets/ggplot02.png" alt="alt text" width="100%">
#' 
#' ---
#' 
#' <img src="assets/ggplot03.png" alt="alt text" width="70%">
#' 
#' ---
#' 
#' <img src="assets/ggplot05.png" alt="alt text" width="80%">
#' 
#' ---
#' 
#' <img src="assets/ggplot06.png" alt="alt text" width="100%">
#' 
#' ---
#' 
#' ### Three Variables
#' <img src="assets/ggplot07.png" alt="alt text" width="100%">
#' 
#' ---
#' 
#' ### Stats
#' Visualize a data transformation
#' 
#' <img src="assets/ggplotStat01.png" alt="alt text" width="100%">
#' 
#' * Each stat creates additional variables with a common ``..name..`` syntax
#' * Often two ways: `stat_bin(geom="bar")`  OR  `geom_bar(stat="bin")`
#' 
#' ---
#' 
#' <img src="assets/ggplotStat02.png" alt="alt text" width="100%">
#' 
#' ---
#' 
#' <img src="assets/ggplotStat03.png" alt="alt text" width="80%">
#' 
#' ## Specifying Scales
#' 
#' <img src="assets/ggplotScales01.png" alt="alt text" width="100%">
#' 
#' ---
#' 
#' ### Discrete color: default
#' 
## ------------------------------------------------------------------------
b=ggplot(mpg,aes(fl))+geom_bar( aes(fill = fl)); b

#' 
#' ---
#' 
#' ### Discrete color: brewer
#' 
## ------------------------------------------------------------------------
b+scale_fill_brewer( palette = "Blues")

#' 
#' 
#' ---
#' 
#' ### Discrete color: greys
#' 
## ------------------------------------------------------------------------
b+scale_fill_grey( start = 0.2, end = 0.8, na.value = "red")

#' 
#' ---
#' 
#' ### Continuous color: defaults
#' 
## ------------------------------------------------------------------------
a <- ggplot(mpg, aes(hwy)) + geom_dotplot( aes(fill = ..x..)); a

#' 
#' ---
#' 
#' ### Continuous color: `gradient`
#' 
## ------------------------------------------------------------------------
a + scale_fill_gradient( low = "red", high = "yellow")

#' 
#' ---
#' 
#' ### Continuous color: `gradient2`
#' 
## ------------------------------------------------------------------------
a + scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 25)

#' 
#' ---
#' 
#' ### Continuous color: `gradientn`
#' 
## ------------------------------------------------------------------------
a + scale_fill_gradientn( colours = rainbow(10))

#' 
#' ## Coordinate Systems
#' 
#' <img src="assets/ggplotCoords.png" alt="alt text" width="55%">
#' 
#' ## Position
#' 
#' <img src="assets/ggplotPosition.png" alt="alt text" width="80%">
#' 
#' 
#' 
#' ## Themes
#' 
#' <img src="assets/ggplotThemes.png" alt="alt text" width="80%">
#' 
#' 
#' ## Colophon
#' 
#' Sources:
#' *  [ggplot cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)
#' * 
#' 
#' Licensing: 
#' * Presentation: [CC-BY-3.0 ](http://creativecommons.org/licenses/by/3.0/us/)
#' * Source code: [MIT](http://opensource.org/licenses/MIT) 
#' 
