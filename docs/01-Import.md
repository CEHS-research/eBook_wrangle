# Data In and Out

--------------------------------------

## Importing Data

`R` can import nearly any file type, but most importantly, it can work with CSV, SPSS, and Excel (since they are the most common forms for students in this course).

### In a package

First, some packages come with data. You can access these data by using:


```r
data("data_name")
```

For example, `dplyr` comes with a star wars data set:


```r
library(dplyr)
data("starwars")
starwars
```

```
## # A tibble: 87 × 14
##    name    height  mass hair_color  skin_color eye_color birth_year sex   gender
##    <chr>    <int> <dbl> <chr>       <chr>      <chr>          <dbl> <chr> <chr> 
##  1 Luke S…    172    77 blond       fair       blue            19   male  mascu…
##  2 C-3PO      167    75 <NA>        gold       yellow         112   none  mascu…
##  3 R2-D2       96    32 <NA>        white, bl… red             33   none  mascu…
##  4 Darth …    202   136 none        white      yellow          41.9 male  mascu…
##  5 Leia O…    150    49 brown       light      brown           19   fema… femin…
##  6 Owen L…    178   120 brown, grey light      blue            52   male  mascu…
##  7 Beru W…    165    75 brown       light      blue            47   fema… femin…
##  8 R5-D4       97    32 <NA>        white, red red             NA   none  mascu…
##  9 Biggs …    183    84 black       light      brown           24   male  mascu…
## 10 Obi-Wa…    182    77 auburn, wh… fair       blue-gray       57   male  mascu…
## # … with 77 more rows, and 5 more variables: homeworld <chr>, species <chr>,
## #   films <list>, vehicles <list>, starships <list>
```

### R (.RData)

When data are saved from `R`, it can be saved as a `.RData` file. To import these, we can use:


```r
load("file.RData")
```

where `"file.RData"` is the name of the file you are importing.

### CSV, SPSS, Excel, Etc.

The others can imported using the `rio` package's `import()` function.


```r
data_csv <- import("file.csv")
data_excel <- import("file.xlsx")
data_spss <- import("file.sav")
```


### By hand `tribble()`

You can also enter data by hand using the `tribble()` function from the `tidyverse`.


```r
tribble(
  ~var1, ~var2,
  10,    "psychology",
  12,    "biology",
  7,     "psychology"
)
```

```
## # A tibble: 3 × 2
##    var1 var2      
##   <dbl> <chr>     
## 1    10 psychology
## 2    12 biology   
## 3     7 psychology
```


--------------------------------------

## Saving Data

You can always save data but often it isn't necessary. Why is that? Because you will save your code that does all the stuff you want to do with the data anyway so no need to save it. However, sometimes other researchers want access to the cleaned data and they don't use `R` so we'll show a few examples.

### R (.RData)


```r
save(data, "file.RData")
```

### CSV and Excel


```r
write_csv(data, "file.csv")
```


### SPSS (.sav)


```r
library(haven)
write_sav(data, "file.sav")
```





