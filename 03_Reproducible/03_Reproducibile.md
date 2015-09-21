# Reproducible Research
Adam M. Wilson  
September 2015  


# Reproducible <br> Research

Scripting, RMarkdown, & Git


## Overview
- Definitions, motives, history, spectrum
- Current practices 
- A selection of tools to improve reproducibility 
- Challenges, standards & our role in the future of reproducible research

<small>[Slides based on Ben Marwick's presentation to the UW Center for Statistics and Social Sciences (12 March 2014)](https://github.com/benmarwick/CSSS-Primer-Reproducible-Research) ([OrcID](http://orcid.org/0000-0001-7879-4531))</small>

---

> "The goal of reproducible research is to tie specific instructions to data analysis and experimental data so that scholarship can be recreated, better understood and verified."  <small> Max Kuhn, CRAN Task View: Reproducible Research </small>


## History of reproducible research

- Mathematics (400 BC?)
- Write scientiﬁc paper, Galileo, Pasteur, etc.  (1660s?)
- Publish a pidgin algorithm and describe simulation datasets (1950s?)
- Sell magtape of code and data (1970s?)
- Place idiosyncratic dataset & software at website (1990s?)
- Publish datasets and scripts at website, eg. biology, political science, genetics, statistics (2000s?)
- Hosted integrated code and data (2020s?)

<small>Gavish & Gonoho AAAS 2011, Oxberry 2013</small>


## Motivations: <br> Claerbout's principle

> "An article about computational result is advertising, not scholarship. The actual scholarship is the full software environment, code and data, that produced the result." <small> Claerbout and Karrenbach, Proceedings of the 62nd Annual International Meeting of the Society of Exploration Geophysics. 1992</small>



## Benefits are straightforward

- **Verification & Reliability**: Find and fix bugs. Today's results == tomorrow's.
- **Transparency**: increased citation count, broader impact, improved institutional memory
- **Efficiency**: Reduces duplication of effort. Payoff in the (not so) long run
- **Flexibility**: When you don’t 'point-and-click' you gain many new analytic options.

## But limitations are substantial


**Technical**

- Classified/sensitive/big data
- Nondisclosure agreements & intellectual property 
- Software licensing issues
- Competition
- Neither necessary nor sufficient for correctness (but essential for dispute resolution)


**Cultural & personal**

- Few researchers follow even minimal reproducibility standards.
- Few expect reproducibility 
- No uniform standards of reproducibility, so no established user base
- Inertia & embarassment



## Our work exists on a spectrum of reproducibility
<img src="figures/peng-spectrum.jpg" alt="alt text" width="800">

<small>Peng 2011, Science 334(6060) pp. 1226-1227</small>


## Goal is to expose the reader to more of the research workflow


<img src="figures/peng-pipeline.jpg" alt="alt text" width="800">

<small><small>http://www.stodden.net/AMP2011/slides/pengslides.pdf</small></small>


## Common practices of many scientists  {.columns-2}

- Enter data in Excel
- Use Excel for data cleaning & descriptive statistics
- Import data into SPSS/SAS/Stata for further analysis
- Use point-and-click options to run statistical analyses
- Copy & paste output to Word document, repeatedly

<br><br>
<br><br>

<small>![alt text](figures/lemon.png)</small>


## Common practices of many scientists {.columns-2}


- Version control is ad hoc
- Excel handles missing data inconsistently and sometimes incorrectly 
- Excel uses poor algorithms for many functions
- Scripting is possible but rare 

<br> <br><br>
<br><br>
<br><br><br>

<img src="figures/phd-comic-vcs.gif" alt="alt text" width="500">


## Click trails are ephemeral & dangerous

- Lots of human effort for tedious & time-wasting tasks
- Error-prone due to manual & ad hoc data handling (column and row offsets are common)
- Difficult to record -  hard to reconstruct a 'click history'
- Tiny changes in data or method require extensive reworking efforts



![alt text](figures/contrails.jpg)


## Case study: Reinhart and Rogoff controversy

![alt text](figures/reinhart_rogoff_coding_error_0.png)


- Claimed high debt-to-GDP ratios led to low GDP growth
- Threshold to growth at a debt-to-GDP ratio of >90%
- Substantial popular impact on autsterity politics 


## Case study: Reinhart and Rogoff controversy

<img src="figures/reinhart_rogoff_econ_mag.png" alt="alt text" width="500">

A coding error in their Excel spreadsheet sliced several countries out of the data set....
[The Economist](http://www.economist.com/news/finance-and-economics/21576362-seminal-analysis-relationship-between-debt-and-growth-comes-under)


## Case study: Gay Marrage

#### In May 2015 _Science_ retracted a study of how canvassers can sway people's opinions about gay marriage published just 5 months ago.

> Original survey data not made available for independent reproduction of results. + Survey incentives misrepresented. + Sponsorship statement false. 
<small>- Science Editor-in-Chief Marcia McNutt</small>

Two Berkeley grad students who attempted to replicate the study quickly discovered that the data must have been faked.

[Source](http://news.sciencemag.org/policy/2015/05/science-retracts-gay-marriage-paper-without-lead-author-s-consent)

---
## Case study: Seizure Medicine

#### 2013 Seizure study retracted after authors realize data got "terribly mixed"
> The article has been retracted at the request of the authors. After carefully re-examining the data presented in the article, they identified that data of two different hospitals got terribly mixed. The published results cannot be reproduced in accordance with scientific and clinical correctness. <small> Authors of Low Dose Lidocaine for Refractory Seizures in Preterm Neonates </small>

[Source](http://retractionwatch.com/2013/02/01/seizure-study-retracted-after-authors-realize-data-got-terribly-mixed/)


## Bad spreadsheet merge kills depression paper, quick fix resurrects it
Authors informed the journal that the merge of lab results and other survey data used in the paper resulted in an error regarding the identification codes. Results of the analyses were based on the data set in which this error occurred. Further analyses established the results reported in this manuscript and interpretation of the data are not correct.

> "Lower levels of CSF IL-6 were associated with current depression and with future depression […]" <small>Original conclusion</small>

> "Higher levels of CSF IL-6 and IL-8 were associated with current depression […]" <small> Revised conclusion </small>

[Source](http://retractionwatch.com/2014/07/01/bad-spreadsheet-merge-kills-depression-paper-quick-fix-resurrects-it/)


## Scripted analyses are superior  {.columns-2}

  <img src="figures/open-science.png" alt="alt text" width="100%">


  - Plain text files readable for a _long_ time
  - Improved transparency, automation, maintanability, accessibility, standardisation, modularity, portability, efficiency, communicability of process (what more could we want?)
  - Steeper learning curve  



## Literate statistical programming 

> "Instead of imagining that our main task is to instruct a computer what to do, let us concentrate rather on explaining to humans what we want the computer to do." <small>Donald E. Knuth, Literate Programming, 1984</small>



For example...
Let's calculate the current time in R.

```r
time <- format(Sys.time(), "%a %d %b %X %Y")
```
The text and R code are interwoven in the output:

The time is `` `r time` ``

The time is Mon 21 Sep 15:05:21 2015



## Literate programming: for and against   {.columns-2}

**For**

- Text & code in one place, in logical order
- Tables and figures automatically updated
- Automatic test when building document


**Against**

- Text and code in one place; can be hard to read
- Can slow down the processing of documents (use caching!)

# Reproducible Research in R

## Need a programming language  {.columns-2}

The machine-readable part: R

* R: Free, open source, cross-platform, highly interactive, huge user community in academica and private sector
* R packages an ideal 'Compendium'?
* Scriptability → R
* Literate programming → R Markdown
* Version control → Git / GitHub

<img src="figures/r-project.jpg" alt="alt text" width="100">


> "both a container for the different elements that make up the document and its computations (i.e. text, code, data, etc.), and as a means for distributing, managing and updating the collection... allow us to move from an era of advertisement to one where our scholarship itself is published" <small>Gentleman and Temple Lang 2004</small>


## Very low barrier to documentation of code with roxygen2


<img src="figures/roxygen2.jpg" alt="alt text" width="800">


## Interactive charts in the browser with the rCharts package

<link rel='stylesheet' href=//cdnjs.cloudflare.com/ajax/libs/nvd3/1.1.15-beta/nv.d3.min.css>
<script type='text/javascript' src=//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js></script>
<script type='text/javascript' src=//d3js.org/d3.v3.min.js></script>
<script type='text/javascript' src=//cdnjs.cloudflare.com/ajax/libs/nvd3/1.1.15-beta/nv.d3.min.js></script>
<script type='text/javascript' src=//nvd3.org/assets/lib/fisheye.js></script> 
 <style>
  .rChart {
    display: block;
    margin-left: auto; 
    margin-right: auto;
    width: 800px;
    height: 400px;
  }  
  </style>
<div id = 'chart4d9d5e937b72' class = 'rChart nvd3'></div>
<script type='text/javascript'>
 $(document).ready(function(){
      drawchart4d9d5e937b72()
    });
    function drawchart4d9d5e937b72(){  
      var opts = {
 "dom": "chart4d9d5e937b72",
"width":    800,
"height":    400,
"x": "wt",
"y": "mpg",
"type": "scatterChart",
"id": "chart4d9d5e937b72" 
},
        data = [
 {
 "mpg":             21,
"cyl":              6,
"disp":            160,
"hp":            110,
"drat":            3.9,
"wt":           2.62,
"qsec":          16.46,
"vs":              0,
"am":              1,
"gear":              4,
"carb":              4 
},
{
 "mpg":             21,
"cyl":              6,
"disp":            160,
"hp":            110,
"drat":            3.9,
"wt":          2.875,
"qsec":          17.02,
"vs":              0,
"am":              1,
"gear":              4,
"carb":              4 
},
{
 "mpg":           22.8,
"cyl":              4,
"disp":            108,
"hp":             93,
"drat":           3.85,
"wt":           2.32,
"qsec":          18.61,
"vs":              1,
"am":              1,
"gear":              4,
"carb":              1 
},
{
 "mpg":           21.4,
"cyl":              6,
"disp":            258,
"hp":            110,
"drat":           3.08,
"wt":          3.215,
"qsec":          19.44,
"vs":              1,
"am":              0,
"gear":              3,
"carb":              1 
},
{
 "mpg":           18.7,
"cyl":              8,
"disp":            360,
"hp":            175,
"drat":           3.15,
"wt":           3.44,
"qsec":          17.02,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              2 
},
{
 "mpg":           18.1,
"cyl":              6,
"disp":            225,
"hp":            105,
"drat":           2.76,
"wt":           3.46,
"qsec":          20.22,
"vs":              1,
"am":              0,
"gear":              3,
"carb":              1 
},
{
 "mpg":           14.3,
"cyl":              8,
"disp":            360,
"hp":            245,
"drat":           3.21,
"wt":           3.57,
"qsec":          15.84,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              4 
},
{
 "mpg":           24.4,
"cyl":              4,
"disp":          146.7,
"hp":             62,
"drat":           3.69,
"wt":           3.19,
"qsec":             20,
"vs":              1,
"am":              0,
"gear":              4,
"carb":              2 
},
{
 "mpg":           22.8,
"cyl":              4,
"disp":          140.8,
"hp":             95,
"drat":           3.92,
"wt":           3.15,
"qsec":           22.9,
"vs":              1,
"am":              0,
"gear":              4,
"carb":              2 
},
{
 "mpg":           19.2,
"cyl":              6,
"disp":          167.6,
"hp":            123,
"drat":           3.92,
"wt":           3.44,
"qsec":           18.3,
"vs":              1,
"am":              0,
"gear":              4,
"carb":              4 
},
{
 "mpg":           17.8,
"cyl":              6,
"disp":          167.6,
"hp":            123,
"drat":           3.92,
"wt":           3.44,
"qsec":           18.9,
"vs":              1,
"am":              0,
"gear":              4,
"carb":              4 
},
{
 "mpg":           16.4,
"cyl":              8,
"disp":          275.8,
"hp":            180,
"drat":           3.07,
"wt":           4.07,
"qsec":           17.4,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              3 
},
{
 "mpg":           17.3,
"cyl":              8,
"disp":          275.8,
"hp":            180,
"drat":           3.07,
"wt":           3.73,
"qsec":           17.6,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              3 
},
{
 "mpg":           15.2,
"cyl":              8,
"disp":          275.8,
"hp":            180,
"drat":           3.07,
"wt":           3.78,
"qsec":             18,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              3 
},
{
 "mpg":           10.4,
"cyl":              8,
"disp":            472,
"hp":            205,
"drat":           2.93,
"wt":           5.25,
"qsec":          17.98,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              4 
},
{
 "mpg":           10.4,
"cyl":              8,
"disp":            460,
"hp":            215,
"drat":              3,
"wt":          5.424,
"qsec":          17.82,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              4 
},
{
 "mpg":           14.7,
"cyl":              8,
"disp":            440,
"hp":            230,
"drat":           3.23,
"wt":          5.345,
"qsec":          17.42,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              4 
},
{
 "mpg":           32.4,
"cyl":              4,
"disp":           78.7,
"hp":             66,
"drat":           4.08,
"wt":            2.2,
"qsec":          19.47,
"vs":              1,
"am":              1,
"gear":              4,
"carb":              1 
},
{
 "mpg":           30.4,
"cyl":              4,
"disp":           75.7,
"hp":             52,
"drat":           4.93,
"wt":          1.615,
"qsec":          18.52,
"vs":              1,
"am":              1,
"gear":              4,
"carb":              2 
},
{
 "mpg":           33.9,
"cyl":              4,
"disp":           71.1,
"hp":             65,
"drat":           4.22,
"wt":          1.835,
"qsec":           19.9,
"vs":              1,
"am":              1,
"gear":              4,
"carb":              1 
},
{
 "mpg":           21.5,
"cyl":              4,
"disp":          120.1,
"hp":             97,
"drat":            3.7,
"wt":          2.465,
"qsec":          20.01,
"vs":              1,
"am":              0,
"gear":              3,
"carb":              1 
},
{
 "mpg":           15.5,
"cyl":              8,
"disp":            318,
"hp":            150,
"drat":           2.76,
"wt":           3.52,
"qsec":          16.87,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              2 
},
{
 "mpg":           15.2,
"cyl":              8,
"disp":            304,
"hp":            150,
"drat":           3.15,
"wt":          3.435,
"qsec":           17.3,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              2 
},
{
 "mpg":           13.3,
"cyl":              8,
"disp":            350,
"hp":            245,
"drat":           3.73,
"wt":           3.84,
"qsec":          15.41,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              4 
},
{
 "mpg":           19.2,
"cyl":              8,
"disp":            400,
"hp":            175,
"drat":           3.08,
"wt":          3.845,
"qsec":          17.05,
"vs":              0,
"am":              0,
"gear":              3,
"carb":              2 
},
{
 "mpg":           27.3,
"cyl":              4,
"disp":             79,
"hp":             66,
"drat":           4.08,
"wt":          1.935,
"qsec":           18.9,
"vs":              1,
"am":              1,
"gear":              4,
"carb":              1 
},
{
 "mpg":             26,
"cyl":              4,
"disp":          120.3,
"hp":             91,
"drat":           4.43,
"wt":           2.14,
"qsec":           16.7,
"vs":              0,
"am":              1,
"gear":              5,
"carb":              2 
},
{
 "mpg":           30.4,
"cyl":              4,
"disp":           95.1,
"hp":            113,
"drat":           3.77,
"wt":          1.513,
"qsec":           16.9,
"vs":              1,
"am":              1,
"gear":              5,
"carb":              2 
},
{
 "mpg":           15.8,
"cyl":              8,
"disp":            351,
"hp":            264,
"drat":           4.22,
"wt":           3.17,
"qsec":           14.5,
"vs":              0,
"am":              1,
"gear":              5,
"carb":              4 
},
{
 "mpg":           19.7,
"cyl":              6,
"disp":            145,
"hp":            175,
"drat":           3.62,
"wt":           2.77,
"qsec":           15.5,
"vs":              0,
"am":              1,
"gear":              5,
"carb":              6 
},
{
 "mpg":             15,
"cyl":              8,
"disp":            301,
"hp":            335,
"drat":           3.54,
"wt":           3.57,
"qsec":           14.6,
"vs":              0,
"am":              1,
"gear":              5,
"carb":              8 
},
{
 "mpg":           21.4,
"cyl":              4,
"disp":            121,
"hp":            109,
"drat":           4.11,
"wt":           2.78,
"qsec":           18.6,
"vs":              1,
"am":              1,
"gear":              4,
"carb":              2 
} 
]
  
      if(!(opts.type==="pieChart" || opts.type==="sparklinePlus" || opts.type==="bulletChart")) {
        var data = d3.nest()
          .key(function(d){
            //return opts.group === undefined ? 'main' : d[opts.group]
            //instead of main would think a better default is opts.x
            return opts.group === undefined ? opts.y : d[opts.group];
          })
          .entries(data);
      }
      
      if (opts.disabled != undefined){
        data.map(function(d, i){
          d.disabled = opts.disabled[i]
        })
      }
      
      nv.addGraph(function() {
        var chart = nv.models[opts.type]()
          .width(opts.width)
          .height(opts.height)
          
        if (opts.type != "bulletChart"){
          chart
            .x(function(d) { return d[opts.x] })
            .y(function(d) { return d[opts.y] })
        }
          
         
        
          
        

        
        
        
      
       d3.select("#" + opts.id)
        .append('svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

       nv.utils.windowResize(chart.update);
       return chart;
      });
    };
</script>

## Interactive charts in the browser with the rCharts package

<link rel='stylesheet' href=//cdnjs.cloudflare.com/ajax/libs/nvd3/1.1.15-beta/nv.d3.min.css>
<script type='text/javascript' src=//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js></script>
<script type='text/javascript' src=//d3js.org/d3.v3.min.js></script>
<script type='text/javascript' src=//cdnjs.cloudflare.com/ajax/libs/nvd3/1.1.15-beta/nv.d3.min.js></script>
<script type='text/javascript' src=//nvd3.org/assets/lib/fisheye.js></script> 
 <style>
  .rChart {
    display: block;
    margin-left: auto; 
    margin-right: auto;
    width: 800px;
    height: 500px;
  }  
  </style>
<div id = 'chart4d9d7e88ec9' class = 'rChart nvd3'></div>
<script type='text/javascript'>
 $(document).ready(function(){
      drawchart4d9d7e88ec9()
    });
    function drawchart4d9d7e88ec9(){  
      var opts = {
 "dom": "chart4d9d7e88ec9",
"width":    800,
"height":    500,
"x": "Hair",
"y": "Freq",
"group": "Eye",
"type": "multiBarChart",
"id": "chart4d9d7e88ec9" 
},
        data = [
 {
 "Hair": "Black",
"Eye": "Brown",
"Sex": "Male",
"Freq":             32 
},
{
 "Hair": "Brown",
"Eye": "Brown",
"Sex": "Male",
"Freq":             53 
},
{
 "Hair": "Red",
"Eye": "Brown",
"Sex": "Male",
"Freq":             10 
},
{
 "Hair": "Blond",
"Eye": "Brown",
"Sex": "Male",
"Freq":              3 
},
{
 "Hair": "Black",
"Eye": "Blue",
"Sex": "Male",
"Freq":             11 
},
{
 "Hair": "Brown",
"Eye": "Blue",
"Sex": "Male",
"Freq":             50 
},
{
 "Hair": "Red",
"Eye": "Blue",
"Sex": "Male",
"Freq":             10 
},
{
 "Hair": "Blond",
"Eye": "Blue",
"Sex": "Male",
"Freq":             30 
},
{
 "Hair": "Black",
"Eye": "Hazel",
"Sex": "Male",
"Freq":             10 
},
{
 "Hair": "Brown",
"Eye": "Hazel",
"Sex": "Male",
"Freq":             25 
},
{
 "Hair": "Red",
"Eye": "Hazel",
"Sex": "Male",
"Freq":              7 
},
{
 "Hair": "Blond",
"Eye": "Hazel",
"Sex": "Male",
"Freq":              5 
},
{
 "Hair": "Black",
"Eye": "Green",
"Sex": "Male",
"Freq":              3 
},
{
 "Hair": "Brown",
"Eye": "Green",
"Sex": "Male",
"Freq":             15 
},
{
 "Hair": "Red",
"Eye": "Green",
"Sex": "Male",
"Freq":              7 
},
{
 "Hair": "Blond",
"Eye": "Green",
"Sex": "Male",
"Freq":              8 
} 
]
  
      if(!(opts.type==="pieChart" || opts.type==="sparklinePlus" || opts.type==="bulletChart")) {
        var data = d3.nest()
          .key(function(d){
            //return opts.group === undefined ? 'main' : d[opts.group]
            //instead of main would think a better default is opts.x
            return opts.group === undefined ? opts.y : d[opts.group];
          })
          .entries(data);
      }
      
      if (opts.disabled != undefined){
        data.map(function(d, i){
          d.disabled = opts.disabled[i]
        })
      }
      
      nv.addGraph(function() {
        var chart = nv.models[opts.type]()
          .width(opts.width)
          .height(opts.height)
          
        if (opts.type != "bulletChart"){
          chart
            .x(function(d) { return d[opts.x] })
            .y(function(d) { return d[opts.y] })
        }
          
         
        
          
        

        
        
        
      
       d3.select("#" + opts.id)
        .append('svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

       nv.utils.windowResize(chart.update);
       return chart;
      });
    };
</script>


## Need a document formatting language  {.columns-2}

<img src="figures/markdown.png" alt="alt text" width="300">

Markdown: lightweight document formatting syntax. Easy to write, read and publish as-is.


The human-readable part

`rmarkdown`: 
- minor extensions to allow R code display and execution
- embed images in html files (convenient for sharing)
- equations

## Dynamic documents in R  {.columns-2}

knitr - descendant of Sweave  

Engine for dynamic report generation in R

<img src="figures/knitr.png" alt="alt text" width="200">

<br> 

- Narrative and code in the same file or explicitly linked
- When data or narrative are updated, the document is automatically updated
- Data treated as 'read only'
- Output treated as disposable

## Pandoc: document converter  {.columns-2}


<img src="figures/pandoc-workflow-rmd-md.png" alt="alt text" width="100%">
<small><small>http://kieranhealy.org/blog/archives/2014/01/23/plain-text/ </small></small>

A universal document converter, open source, cross-platform

* Write code and narrative in rmarkdown   
* knitr->markdown (with computation)   
* use pandoc to get HTML/PDF/DOCX


## Tracking changes with version control 

**Payoffs**

- Eases collaboration
- Can track changes in any file type (ideally plain text)
- Can revert file to any point in its tracked history

**Costs**
- Learning curve


<img src="figures/git.png" alt="alt text" width="30%">
<img src="figures/github.png" alt="alt text" width="30%">
<img src="figures/bitbucket.png" alt="alt text" width="30%">

## Environment for reproducible research   {.columns-2}

<img src="figures/rstudio.png" alt="alt text" width="30%">

* integrated R console
* deep support for markdown and git
* package development tools, etc. etc.

> RStudio 'projects' make version control & document preparation simple


## Depositing code and data

**Payoffs**
- Free space for hosting (and paid options)
- Assignment of persistent DOIs
- Tracking citation metrics 

**Costs**
- Sometimes license restrictions (CC-BY & CC0)
- Limited or no private storage space


<img src="figures/figshare.png" alt="alt text" width="30%">
<img src="figures/dryad.png" alt="alt text" width="30%">
<img src="figures/zenodo.png" alt="alt text" width="30%">


## A hierarchy of reproducibility 

- **Good**: Use code with an integrated development environment (IDE). Minimize pointing and clicking (RStudio)
- **Better**: Use version control. Help yourself keep track of changes, fix bugs and improve project management (RStudio & Git & GitHub or BitBucket)
- **Best**: Use embedded narrative and code to explicitly link code, text and data, save yourself time, save reviewers time, improve your code. (RStudio & Git & GitHub or BitBucket & rmarkdown & knitr & data repository)

##

<img src="figures/VictoriaStoddenIASSISTJune2010-reasons-to.png" alt="alt text" width="800">
<small>Stodden (IASSIST 2010) sampled American academics registered at the Machine Learning conference NIPS (134 responses from 593 requests (23%). Red = communitarian norms, Blue = private incentives</small>

##

<img src="figures/VictoriaStoddenIASSISTJune2010-reasons.png" alt="alt text" width="800">
<small>Stodden (IASSIST 2010) sampled American academics registered at the Machine Learning conference NIPS (134 responses from 593 requests (23%). Red = communitarian norms, Blue = private incentives</small>


## Standards to normalise reproducible research

Reproducible Research Standard (Stodden 2009)

- The full compendium on the internet
- Media such as text, figures, tables with Creative Commons Attribution license (CC-BY) 
 - Code with one of Apache 2.0, MIT, LGPL, BSD, etc.
 - Original "selection and arrangement" of data with CC0 or CC-BY

## Biggest challenge: culture change

Promote culture change through positive attribution 

Implement mechanisms to indicate & encourage **degrees of compliance** (ie. clear definitions for different levels of reproducibility), cf. Stodden's:

 - **'Reproducible'**: compendium of text-code-data online
 - **'Reproduced'**: compendium available and independently reproduced 
 - **'Semi-Reproducible'**: when the full compendium is not released
 - **'Semi-Reproduced'**: independent reproduction with other data
 - **'Perpetually Reproducible'**: streaming data

## Our role in the future of reproducible research (Leveque et al 2012)

- Train students by putting homework, assignments & dissertations on the reproducible research spectrum
- Publish examples of reproducible research in our field
- Request code & data when reviewing
- Submit to & review for journals that support reproducible research
- Critically review & audit data management plans in grant proposals
- Consider reproducibility wherever possible in hiring, promotion & reference letters.


#  Demo: let's get started

## Creating an account on [GitHub](github.com)

1. Create a GitHub account at [https://github.com/](https://github.com/)
    * This will be a public account associated with your name
    * Choose a username wisely for future use
    * Don't worry about details, you can fill them in later
2. Create a repository called _demo_
    * Add a brief and informative description
    * Choose "Public"
    * Check the box for "Initialize this repository with a README"
3. Click "Create Repository"

<small> Demo drawn using materials from Dr. Çetinkaya-Rundel</small>

## Cloning the repository

1. Go to RStudio
    * File -> New Project
    * Version Control: Checkout a project from a version control repository
    * Git: Clone a project from a repository
2. Fill in the info:
    * URL: use HTTPS address
    * Create as a subdirectory of: Browse and create a new folder called `GEO503` (or similar)
    
## R Markdown

**Live demo** 

Cheatsheet:

<a href="https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf"> <img src="figures/rmarkdown.png" alt="alt text" width="400"></a>

<small><small><small>[https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)</small></small></small>


## Create new file
File -> New File -> RMarkdown -> Document -> HTML

<img src="figures/rmarkdownwindow.png" alt="alt text" width="500">

## Step 1: Load packages

All R code to be run must be in a _code chunk_ like this:

```r
#```{r,eval=F}
CODE HERE
#```
```

Load these packages in a code chunk:


```r
library(dplyr)
library(ggplot2)
library(spocc)
```

> Do you think you should put `install.packages()` calls in your script?


## Step 2: Load data

Now use the `occ()` function to download all the _occurrence_ records for the American robin (_Turdus migratorius_) from the [Global Biodiversity Information Facility](gbif.org).

<img src="figures/Turdus-migratorius-002.jpg" alt="alt text" width="200">

<small><small><small>Licensed under CC BY-SA 3.0 via [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Turdus-migratorius-002.jpg#/media/File:Turdus-migratorius-002.jpg)</small></small></small>

This can take a few seconds.

```r
## define which species to query
sp='Turdus migratorius'

## run the query and convert to data.frame()
d = occ(query=sp, from='ebird',limit = 10000) %>% occ2df()
```


## Step 3: 

ggplot(d,aes(x=format(date,"%m"),y=latitude,group=1))+
geom_point()+
geom_smooth()


## Step 4:
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

## Step 3: Commit and push all changes to GitHub

1. Stage
2. Commit (with a message)
3. Push


##  Final

> Abandoning the habit of secrecy in favor of process transparency and peer review was the crucial step by which alchemy became chemistry.<small>Raymond, E. S., 2004, The art of UNIX programming: Addison-Wesley.</small>

## Colophon

[Slides based on Ben Marwick's presentation to the UW Center for Statistics and Social Sciences (12 March 2014)](https://github.com/benmarwick/CSSS-Primer-Reproducible-Research) ([OrcID](http://orcid.org/0000-0001-7879-4531))

Licensing: 
* Presentation: [CC-BY-3.0 ](http://creativecommons.org/licenses/by/3.0/us/)
* Source code: [MIT](http://opensource.org/licenses/MIT) 


## References

See [Rpres file on github](https://raw.github.com/benmarwick/CSSS-Primer-Reproducible-Research/master/CSSS_WI14_Reproducibility.Rpres) for full references and sources


