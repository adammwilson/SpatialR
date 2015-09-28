# Reproducible Research II
Adam M. Wilson  
September 2015  




## Overview

### Questions from last week?

* Got Git?

## Homework Review

##  Today

### Outline

  * Project Proposal
  * More Git
  * More Markdown
  
**Guided Exploration**

  * Reading files
  * Introduction to `ggplot2()`

## Project proposal

**Final project:** 

dynamically generated report of a spatial analysis (minimum 12 page, maximum 30 pages).  

**Project proposal:**

<1 page due next week

1. Introduction to problem/question
2. Proposed data sources
3. Proposed methods
4. Expected results



# Working with Git and GitHub


## Commit to GitHub from within RStudio

### Steps:

1. Stage
2. Commit (with a message)
3. Push

## The 3 states of files

### staged, modified, committed
<img src="assets/staging.png" alt="alt text" width="75%">

The important stuff is hidden in the `.git` folder.



## Staging
<img src="assets/Stage.png" alt="alt text" width="75%">

Select which files you want to commit.

## Committing
<img src="assets/Commit.png" alt="alt text" width="100%">

Add a _commit message_ and click commit.

## Syncing (`push`)
<img src="assets/Push.png" alt="alt text" width="100%">

Click the green arrow to sync with GitHub.

## Github

<img src="assets/Github.png" alt="alt text" width="100%">

Files are updated/stored on GitHub

## Git File Lifecycle

<img src="assets/Lifecycle.png" alt="alt text" width="100%">


## Git command line from RStudio

RStudio has limited functionality.  

<img src="assets/CommandLine.png" alt="alt text" width="75%">


## Git help

```{}
$ git help <verb>
$ git <verb> --help
$ man git-<verb>
```
For example, you can get the manpage help for the config command by running `git help config`

## Git status
<img src="assets/GitCL.png" alt="alt text" width="75%">

Similar to info in git tab in RStudio

## Git config
`git config` shows you all the git configuration settings:

* `user.email`
* `remote.origin.url`  (e.g. to connect to GitHub)

## Branching
Branches used to develop features isolated from each other. 
<img src="assets/merge.png" alt="alt text" width="100%">

Default: _master_ branch. Use other branches for development/collaboration and merge them back upon completion.

## Basic Branching

```{}
$ git checkout -b devel   # create new branch and switch to it


$ git checkout master  #switch back to master
$ git merge devel  #merge in changes from devel branch
```
But we won't do much with branching in this course...

## Git Has Integrity
Everything _checksummed_ before storage and then referred by _checksum_. 

> It’s impossible to change the contents of any file or directory without Git knowing. You can’t lose information in transit or get file corruption without Git being able to detect it.

A 40-character hexadecimal SHA-1 hash:

`24b9da6552252987aa493b52f8696cd6d3b00373`

## Checksum
A way of reducing digital information to a unique ID:

<img src="assets/checksum.jpg" alt="alt text" width="50%">

Git doesn't care about filenames, extensions, etc.  It' the information that matters...


## Git can do far more!

Check out the (free) book [ProGIT](https://git-scm.com/book/en/v2)

<img src="assets/progit2.png" alt="alt text" width="30%">


Or the [cheatsheet](https://training.github.com/kit/downloads/github-git-cheat-sheet.pdf).

## Philosphy  
Remember, the data and code are _real_, the products (tables, figures) are ephemeral...  

# RMarkdown

## RMarkdown: workflow
<img src="assets/Rmarkdown01.png" alt="alt text" width="100%">

## RMarkdown: new file
<img src="assets/Rmarkdown02.png" alt="alt text" width="100%">

## RMarkdown: syntax
<img src="assets/Rmarkdown03.png" alt="alt text" width="70%">

## RMarkdown: output
<img src="assets/Rmarkdown04.png" alt="alt text" width="100%">

## RMarkdown: code
<img src="assets/Rmarkdown05.png" alt="alt text" width="90%">

## RMarkdown: chunks
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

## Chunk examples

R Code Chunks: Displaying Plots

<img src="assets/figure.png" alt="alt text" width="80%">

<img src="04_Reproducibile_files/figure-revealjs/unnamed-chunk-2-1.png" title="" alt="" style="display: block; margin: auto;" />

## Global chunk options

Use  chunk options throughout a document:
<img src="assets/globalOptions.png" alt="alt text" width="100%">


## RMarkdown: render

<img src="assets/Rmarkdown06.png" alt="alt text" width="100%">


## Visualize .md on GitHub

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

## Visualize example
<img src="assets/ghmd.png" alt="alt text" width="75%">


## Explore markdown<->Git

1. Use _File -> New File -> R Markdown_ to create a new markdown file.  
2. Use the Cheatsheet to add sections (`#` and `##`) and some example narrative.  
3. `Stage`, `Commit`, `Push`!
4. Make more changes then `Stage`, `Commit`, `Push`!
4. Explore the markdown file on your GitHub website.  

<br>

### Take 15 minutes & ask questions!


## Colophon

Licensing: 
* Presentation: [CC-BY-3.0 ](http://creativecommons.org/licenses/by/3.0/us/)
* Source code: [MIT](http://opensource.org/licenses/MIT) 

