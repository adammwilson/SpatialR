# Reproducible Research II
Adam M. Wilson  
September 2015  




## Overview

### Questions from last week?

* Got Git?

# Homework Review

#  Today

## Outline
* More Git
* More Markdown
* Introduction to `ggplot2()`
* Introduction to spatial data in R

# Working with Git and GitHub

## Branching
Git branches are 

## Commit to GitHub from within RStudio

Steps:
1. Stage
2. Commit (with a message)
3. Push

# RMarkdown

## RMarkdown
<img src="assets/Rmarkdown01.png" alt="alt text" width="100%">

## RMarkdown
<img src="assets/Rmarkdown02.png" alt="alt text" width="100%">

## RMarkdown
<img src="assets/Rmarkdown03.png" alt="alt text" width="100%">

## RMarkdown
<img src="assets/Rmarkdown04.png" alt="alt text" width="100%">

## RMarkdown
<img src="assets/Rmarkdown05.png" alt="alt text" width="90%">

## Chunk Options
Option      default   effect
----        ---       ----
`eval`        `TRUE`      Evalute the code and include the results
`echo`        `TRUE`      Display the code along with its results
`warning`     `TRUE`      Display warnings
`error`       `FALSE`     Display errors
`message`     `TRUE`      Display messages
`tidy`        `FALSE`     Reformat code to make it 'tidy'
`results`     "markup"    "markup", "asis","hold","hide"
`cache`       `FALSE`     Cache results for future renders
`comment`     `"##"`      Comment character to preface results
`fig.width`   7           Width in inches for plots
`fig.height`  7           Height in inches for plots

## RMarkdown
<img src="assets/Rmarkdown06.png" alt="alt text" width="100%">

## Code Chunks
All R code to be run must be in a _code chunk_ like this:

```r
#```{r,eval=F}
CODE HERE
#```
```

## Chunk examples

R Code Chunks: Displaying Plots

<img src="assets/figure.png" alt="alt text" width="80%">

<img src="04_Reproducibile_files/figure-revealjs/unnamed-chunk-3-1.png" title="" alt="" style="display: block; margin: auto;" />

## Global chunk options

Use  chunk options throughout a document:
<img src="assets/globalOptions.png" alt="alt text" width="100%">

## Easily visualize on GitHub

Update the YAML header to keep the markdown file

From this:

```r
title: "Untitled"
author: "Adam M. Wilson"
date: "September 21, 2015"
output: html_document
```

To this:

```r
title: "Demo"
author: "Adam M. Wilson"
date: "September 21, 2015"
output: 
  html_document:
      keep_md: true
```

And click `knit HTML` to generate the output


## Explore markdown functions

1. Use _File -> New File -> R Markdown_ to create a new markdown file.  
2. Use the Cheatsheet to add sections (`#` and `##`) and some example narrative.  
3. Try changing changing the species name to your favorite species and re-run the report.  
4. Stage, Commit, Push!
5. Explore the markdown file on the GitHub website.  


## Colophon

Licensing: 
* Presentation: [CC-BY-3.0 ](http://creativecommons.org/licenses/by/3.0/us/)
* Source code: [MIT](http://opensource.org/licenses/MIT) 


## References

See Rmd file for full references and sources
