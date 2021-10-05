# Tidy Data

Tidying up data is often where most of the data work happens. It is known by many names--cleaning, wrangling, tidying--but it all ultimately is to make the data in a format that we can analyze it.

## Define Tidy Data

[Tidy data](https://vita.had.co.nz/papers/tidy-data.pdf) are discussed in many resources (e.g., [R for Data Science](https://r4ds.had.co.nz)). "Tidy datasets are all alike but every messy dataset is messy in its own way. Tidy datasets provide a standardized way to link the structure of a dataset (its physical layout) with its semantics (its meaning). In this section, I’ll provide some standard vocabulary for describing the structure and semantics of a dataset, and then use those definitions to define tidy data," (https://vita.had.co.nz/papers/tidy-data.pdf).


--------------------------------------

## Tidying (Cleaning) Data

For examples, we are going to import some data from a `.csv` file.


```r
data <- rio::import("data_csv.csv")
```


## Changing Variable Type

Importing data into R can cause your variables to change types. For example, lets see what the race variable class is now that the file has been imported into R.


```r
class(data$Race)
```

```
## [1] "character"
```

As you see, its a character. We want it to be labeled as a factor. We can do this by using the as.factor() function in baseR. Make sure you save it as another variable in your dataset. If you don't assign it to another variable, it will only temporarily show your variable as a factor but not actually change it to a factor for later analyses.


```r
data$RaceF <- as.factor(data$Race)
data$SmokingF <- as.factor(data$smoking)
```

Now lets see what the class of our RaceF variable is.


```r
class(data$RaceF)
```

```
## [1] "factor"
```

Please note- when importing from a SAV file, some factors may be "haven-labelled." Use this technique to change haven-labelled variables into factors as well.

## Changing a whole dataset to a certain class

If you want your whole dataset to be a certain class, you can easily do that in R using map_df(). Let's say we want the whole dataset to be numeric.


```r
library(tidyverse)

data_num <- map_df(data, as.numeric)
tibble::glimpse(data)
```

```
## Rows: 100
## Columns: 16
## $ V1           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17…
## $ ID           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17…
## $ Educ         <int> 14, 15, 23, 14, 22, 15, 23, 21, 21, 20, 13, 12, 22, 12, 2…
## $ Age          <int> 58, 32, 47, 35, 51, 73, 46, 66, 38, 53, 19, 52, 24, 69, 5…
## $ Sex          <chr> "female", "male", "male", "female", "male", "male", "male…
## $ Race         <chr> "other", "black", "other", "other", "white", "white", "la…
## $ Married      <int> 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, …
## $ Income_1     <int> 42504, 45341, 69261, 41654, 66149, 46009, 68791, 62362, 6…
## $ INCOME_2     <int> 56418, 59810, 92139, 56264, 88635, 59918, 91662, 83720, 8…
## $ Depression_1 <int> 23, 20, 16, 14, 10, 14, 13, 6, 20, 11, 24, 21, 12, 10, 10…
## $ Depression_2 <int> 26, 25, 20, 19, 13, 17, 17, 5, 26, 13, 28, 24, 14, 12, 12…
## $ Anx_1        <int> 21, 20, 15, 15, 8, 14, 16, 5, 17, 11, 26, 23, 12, 10, 12,…
## $ Anx_2        <int> 22, 23, 19, 10, 7, 16, 17, 4, 19, 10, 25, 22, 9, 12, 12, …
## $ smoking      <chr> "Non-smoker", "Smoker", "Smoker", "99", "Non-smoker", "No…
## $ RaceF        <fct> other, black, other, other, white, white, latinx, white, …
## $ SmokingF     <fct> Non-smoker, Smoker, Smoker, 99, Non-smoker, Non-smoker, N…
```

As you can see, the character and factor variables that do not contain numbers are unable to be numeric. We will go over how to change that later. You can also change the whole dataset to be factors using the same code, but changing as.numeric to as.factor.

## Janitor Package

The janitor package has useful functions that make it easy to clean your dataset. Use the clean_names() function to make variable names consistent.


```r
library(janitor)

clean_df <- clean_names(data)

tibble::glimpse(clean_df)
```

```
## Rows: 100
## Columns: 16
## $ v1           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17…
## $ id           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17…
## $ educ         <int> 14, 15, 23, 14, 22, 15, 23, 21, 21, 20, 13, 12, 22, 12, 2…
## $ age          <int> 58, 32, 47, 35, 51, 73, 46, 66, 38, 53, 19, 52, 24, 69, 5…
## $ sex          <chr> "female", "male", "male", "female", "male", "male", "male…
## $ race         <chr> "other", "black", "other", "other", "white", "white", "la…
## $ married      <int> 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, …
## $ income_1     <int> 42504, 45341, 69261, 41654, 66149, 46009, 68791, 62362, 6…
## $ income_2     <int> 56418, 59810, 92139, 56264, 88635, 59918, 91662, 83720, 8…
## $ depression_1 <int> 23, 20, 16, 14, 10, 14, 13, 6, 20, 11, 24, 21, 12, 10, 10…
## $ depression_2 <int> 26, 25, 20, 19, 13, 17, 17, 5, 26, 13, 28, 24, 14, 12, 12…
## $ anx_1        <int> 21, 20, 15, 15, 8, 14, 16, 5, 17, 11, 26, 23, 12, 10, 12,…
## $ anx_2        <int> 22, 23, 19, 10, 7, 16, 17, 4, 19, 10, 25, 22, 9, 12, 12, …
## $ smoking      <chr> "Non-smoker", "Smoker", "Smoker", "99", "Non-smoker", "No…
## $ race_f       <fct> other, black, other, other, white, white, latinx, white, …
## $ smoking_f    <fct> Non-smoker, Smoker, Smoker, 99, Non-smoker, Non-smoker, N…
```

Now, all of our variables are lowercase and consistent.

You can also remove columns and/or rows that are completely missing. We do not have any missing rows or columns in our real dataset, so we will make one up to show you how it works.


```r
df <- data.frame(var1 = c(1, NA, 6, 8, 3),
                 var2 = c("a", NA, "c", "s", "y"),
                 var3 = c(NA, NA, NA, NA, NA))

df
```

```
##   var1 var2 var3
## 1    1    a   NA
## 2   NA <NA>   NA
## 3    6    c   NA
## 4    8    s   NA
## 5    3    y   NA
```


```r
remove_empty(df, "rows")
```

```
##   var1 var2 var3
## 1    1    a   NA
## 3    6    c   NA
## 4    8    s   NA
## 5    3    y   NA
```


```r
remove_empty(df, "cols")
```

```
##   var1 var2
## 1    1    a
## 2   NA <NA>
## 3    6    c
## 4    8    s
## 5    3    y
```


```r
remove_empty(df, c("rows", "cols"))
```

```
##   var1 var2
## 1    1    a
## 3    6    c
## 4    8    s
## 5    3    y
```

## Washer function in the Furniture package

Note the use of `head()` to only print 6 rows (instead of all of them).


```r
library(furniture)

washer(clean_df, 99, value = NA) %>% 
  head()
```

```
##   v1 id educ age    sex  race married income_1 income_2 depression_1
## 1  1  1   14  58 female other       0    42504    56418           23
## 2  2  2   15  32   male black       0    45341    59810           20
## 3  3  3   23  47   male other       0    69261    92139           16
## 4  4  4   14  35 female other       1    41654    56264           14
## 5  5  5   22  51   male white       0    66149    88635           10
## 6  6  6   15  73   male white       1    46009    59918           14
##   depression_2 anx_1 anx_2    smoking race_f  smoking_f
## 1           26    21    22 Non-smoker  other Non-smoker
## 2           25    20    23     Smoker  black     Smoker
## 3           20    15    19     Smoker  other     Smoker
## 4           19    15    10       <NA>  other       <NA>
## 5           13     8     7 Non-smoker  white Non-smoker
## 6           17    14    16 Non-smoker  white Non-smoker
```


--------------------------------------

## Tidyverse

### Pipes

```
me %>% 
  wake_up("8:00am") %>% 
  exercise(30, units = "minutes") %>% 
  shower(15, units = "minutes") %>% 
  eat_breakfast("toast") %>% 
  go_to_work("basement")
```

Piping takes what is on the left-hand side and puts it in the right hand side's function. If you look at the code below, you'll see how code looks without a pipe.


```r
summary(clean_df)
```

```
##        v1               id              educ            age       
##  Min.   :  1.00   Min.   :  1.00   Min.   :10.00   Min.   :18.00  
##  1st Qu.: 25.75   1st Qu.: 25.75   1st Qu.:15.00   1st Qu.:35.75  
##  Median : 50.50   Median : 50.50   Median :20.00   Median :49.00  
##  Mean   : 50.50   Mean   : 50.50   Mean   :18.65   Mean   :48.24  
##  3rd Qu.: 75.25   3rd Qu.: 75.25   3rd Qu.:22.00   3rd Qu.:59.25  
##  Max.   :100.00   Max.   :100.00   Max.   :25.00   Max.   :75.00  
##      sex                race              married        income_1    
##  Length:100         Length:100         Min.   :0.00   Min.   :29329  
##  Class :character   Class :character   1st Qu.:0.00   1st Qu.:45348  
##  Mode  :character   Mode  :character   Median :0.00   Median :59840  
##                                        Mean   :0.43   Mean   :56053  
##                                        3rd Qu.:1.00   3rd Qu.:66275  
##                                        Max.   :1.00   Max.   :75987  
##     income_2       depression_1    depression_2       anx_1      
##  Min.   : 39557   Min.   : 4.00   Min.   : 4.00   Min.   :-1.00  
##  1st Qu.: 59985   1st Qu.: 9.00   1st Qu.:11.00   1st Qu.: 8.00  
##  Median : 79867   Median :13.00   Median :17.00   Median :13.50  
##  Mean   : 74689   Mean   :13.68   Mean   :16.47   Mean   :13.26  
##  3rd Qu.: 88179   3rd Qu.:18.00   3rd Qu.:22.00   3rd Qu.:18.00  
##  Max.   :100518   Max.   :25.00   Max.   :31.00   Max.   :26.00  
##      anx_2        smoking             race_f        smoking_f 
##  Min.   : 1.0   Length:100         black :20   99        : 8  
##  1st Qu.: 8.0   Class :character   latinx:33   Non-smoker:70  
##  Median :13.0   Mode  :character   other :14   Smoker    :14  
##  Mean   :13.3                      white :33   NA's      : 8  
##  3rd Qu.:18.0                                                 
##  Max.   :27.0
```

Now, here is what the code looks like using a pipe.


```r
clean_df %>% 
  summary()
```

```
##        v1               id              educ            age       
##  Min.   :  1.00   Min.   :  1.00   Min.   :10.00   Min.   :18.00  
##  1st Qu.: 25.75   1st Qu.: 25.75   1st Qu.:15.00   1st Qu.:35.75  
##  Median : 50.50   Median : 50.50   Median :20.00   Median :49.00  
##  Mean   : 50.50   Mean   : 50.50   Mean   :18.65   Mean   :48.24  
##  3rd Qu.: 75.25   3rd Qu.: 75.25   3rd Qu.:22.00   3rd Qu.:59.25  
##  Max.   :100.00   Max.   :100.00   Max.   :25.00   Max.   :75.00  
##      sex                race              married        income_1    
##  Length:100         Length:100         Min.   :0.00   Min.   :29329  
##  Class :character   Class :character   1st Qu.:0.00   1st Qu.:45348  
##  Mode  :character   Mode  :character   Median :0.00   Median :59840  
##                                        Mean   :0.43   Mean   :56053  
##                                        3rd Qu.:1.00   3rd Qu.:66275  
##                                        Max.   :1.00   Max.   :75987  
##     income_2       depression_1    depression_2       anx_1      
##  Min.   : 39557   Min.   : 4.00   Min.   : 4.00   Min.   :-1.00  
##  1st Qu.: 59985   1st Qu.: 9.00   1st Qu.:11.00   1st Qu.: 8.00  
##  Median : 79867   Median :13.00   Median :17.00   Median :13.50  
##  Mean   : 74689   Mean   :13.68   Mean   :16.47   Mean   :13.26  
##  3rd Qu.: 88179   3rd Qu.:18.00   3rd Qu.:22.00   3rd Qu.:18.00  
##  Max.   :100518   Max.   :25.00   Max.   :31.00   Max.   :26.00  
##      anx_2        smoking             race_f        smoking_f 
##  Min.   : 1.0   Length:100         black :20   99        : 8  
##  1st Qu.: 8.0   Class :character   latinx:33   Non-smoker:70  
##  Median :13.0   Mode  :character   other :14   Smoker    :14  
##  Mean   :13.3                      white :33   NA's      : 8  
##  3rd Qu.:18.0                                                 
##  Max.   :27.0
```

It may not seem to make the code more readable, but the more complex your code is the easier it will be to read it using pipes. It also allows you to connect multiple lines of code without having to overwrite your dataset multiple times. As we go through more data cleaning and wrangling, you'll begin to see how piping makes a difference when coding.

### Subset Data

#### Select function

The select function allows you to pull specific information out of our dataset. You can do this using baseR commands, or with the select function from tidyverse.


```r
head(clean_df[, c("id", "educ", "age")])
```

```
##   id educ age
## 1  1   14  58
## 2  2   15  32
## 3  3   23  47
## 4  4   14  35
## 5  5   22  51
## 6  6   15  73
```

```r
head(clean_df[, c(1:3)])
```

```
##   v1 id educ
## 1  1  1   14
## 2  2  2   15
## 3  3  3   23
## 4  4  4   14
## 5  5  5   22
## 6  6  6   15
```



```r
clean_df %>% 
  select(id, educ, age) %>% 
  head()
```

```
##   id educ age
## 1  1   14  58
## 2  2   15  32
## 3  3   23  47
## 4  4   14  35
## 5  5   22  51
## 6  6   15  73
```

```r
clean_df %>% 
  select(1:3) %>% 
  head()
```

```
##   v1 id educ
## 1  1  1   14
## 2  2  2   15
## 3  3  3   23
## 4  4  4   14
## 5  5  5   22
## 6  6  6   15
```

Each code chunk does the same thing. The first two, using [, is the "base R" way of selecting variables. The last two, using the pipe, is the tidyverse way. Both work great so the choice is yours.


#### starts_with(), ends_with(), contains()

When you use tidyverse, you can pull variables out that have common features. Here are a few examples. Note that we use the select function as well as another function to pull out information. 

This line of code pulls out the variables that start with the word "income".


```r
clean_df %>% 
  select(starts_with("income")) %>% 
  head()
```

```
##   income_1 income_2
## 1    42504    56418
## 2    45341    59810
## 3    69261    92139
## 4    41654    56264
## 5    66149    88635
## 6    46009    59918
```
This code allows you to select all of the variables in your dataset that end with _1 and _2. 


```r
clean_df %>% 
  select(ends_with(c("_1", "_2"))) %>% 
  head()
```

```
##   income_1 depression_1 anx_1 income_2 depression_2 anx_2
## 1    42504           23    21    56418           26    22
## 2    45341           20    20    59810           25    23
## 3    69261           16    15    92139           20    19
## 4    41654           14    15    56264           19    10
## 5    66149           10     8    88635           13     7
## 6    46009           14    14    59918           17    16
```

With this code you can pull out any variables that contain "anx" anywhere in the variable name.


```r
clean_df %>% 
  select(contains("anx")) %>% 
  head()
```

```
##   anx_1 anx_2
## 1    21    22
## 2    20    23
## 3    15    19
## 4    15    10
## 5     8     7
## 6    14    16
```

### Filter, equality/inequality, and/or, within


```r
clean_df[clean_df$anx_1 > 20,]
```

```
##    v1 id educ age    sex   race married income_1 income_2 depression_1
## 1   1  1   14  58 female  other       0    42504    56418           23
## 11 11 11   13  19   male latinx       0    38609    51231           24
## 12 12 12   12  52   male latinx       0    35765    48350           21
## 27 27 27   11  32 female latinx       1    31930    43994           25
## 31 31 31   12  32 female  black       0    35574    48605           20
## 32 32 32   16  32 female  other       1    48240    64209           20
## 39 39 39   23  53   male  white       0    69101    90538           24
## 41 41 41   24  41 female  white       0    71409    96501           25
## 42 42 42   21  48   male  white       0    63792    84229           22
## 56 56 56   20  64   male  other       0    59826    80546           22
## 72 72 72   21  52 female  black       1    62825    84191           25
## 77 77 77   17  50 female  white       0    51535    67826           23
## 86 86 86   16  56 female  black       0    49602    64341           21
## 94 94 94   15  68   male latinx       0    44938    60644           23
## 95 95 95   20  23   male latinx       1    59629    79479           25
## 96 96 96   19  60 female  white       1    56833    75545           20
##    depression_2 anx_1 anx_2    smoking race_f  smoking_f
## 1            26    21    22 Non-smoker  other Non-smoker
## 11           28    26    25       <NA> latinx       <NA>
## 12           24    23    22 Non-smoker latinx Non-smoker
## 27           31    25    27       <NA> latinx       <NA>
## 31           24    21    23 Non-smoker  black Non-smoker
## 32           24    25    25 Non-smoker  other Non-smoker
## 39           29    25    24 Non-smoker  white Non-smoker
## 41           31    26    21 Non-smoker  white Non-smoker
## 42           25    22    25 Non-smoker  white Non-smoker
## 56           25    25    23         99  other         99
## 72           30    25    24 Non-smoker  black Non-smoker
## 77           27    22    24 Non-smoker  white Non-smoker
## 86           25    23    25 Non-smoker  black Non-smoker
## 94           26    24    27 Non-smoker latinx Non-smoker
## 95           29    23    23     Smoker latinx     Smoker
## 96           25    21    20 Non-smoker  white Non-smoker
```

```r
clean_df %>% 
  filter(anx_1 > 20) %>% 
  head()
```

```
##   v1 id educ age    sex   race married income_1 income_2 depression_1
## 1  1  1   14  58 female  other       0    42504    56418           23
## 2 11 11   13  19   male latinx       0    38609    51231           24
## 3 12 12   12  52   male latinx       0    35765    48350           21
## 4 27 27   11  32 female latinx       1    31930    43994           25
## 5 31 31   12  32 female  black       0    35574    48605           20
## 6 32 32   16  32 female  other       1    48240    64209           20
##   depression_2 anx_1 anx_2    smoking race_f  smoking_f
## 1           26    21    22 Non-smoker  other Non-smoker
## 2           28    26    25       <NA> latinx       <NA>
## 3           24    23    22 Non-smoker latinx Non-smoker
## 4           31    25    27       <NA> latinx       <NA>
## 5           24    21    23 Non-smoker  black Non-smoker
## 6           24    25    25 Non-smoker  other Non-smoker
```



```r
clean_df %>% 
  filter(sex == "female") %>% 
  head()
```

```
##   v1 id educ age    sex   race married income_1 income_2 depression_1
## 1  1  1   14  58 female  other       0    42504    56418           23
## 2  4  4   14  35 female  other       1    41654    56264           14
## 3  8  8   21  66 female  white       1    62362    83720            6
## 4  9  9   21  38 female  other       0    62716    84363           20
## 5 10 10   20  53 female  white       1    60309    80255           11
## 6 15 15   22  57 female latinx       1    66286    87292           10
##   depression_2 anx_1 anx_2    smoking race_f  smoking_f
## 1           26    21    22 Non-smoker  other Non-smoker
## 2           19    15    10         99  other         99
## 3            5     5     4 Non-smoker  white Non-smoker
## 4           26    17    19 Non-smoker  other Non-smoker
## 5           13    11    10     Smoker  white     Smoker
## 6           12    12    12 Non-smoker latinx Non-smoker
```


```r
clean_df %>% 
  filter(sex == "female" & race == "black") %>% 
  head()
```

```
##   v1 id educ age    sex  race married income_1 income_2 depression_1
## 1 20 20   21  56 female black       0    62751    84363            5
## 2 31 31   12  32 female black       0    35574    48605           20
## 3 43 43   25  49 female black       0    74573    99489           16
## 4 44 44   21  33 female black       0    63295    84883            8
## 5 60 60   22  25 female black       0    65956    87883           18
## 6 64 64   25  21 female black       0    75987   100466            4
##   depression_2 anx_1 anx_2    smoking race_f  smoking_f
## 1            7     3     3 Non-smoker  black Non-smoker
## 2           24    21    23 Non-smoker  black Non-smoker
## 3           18    15    16 Non-smoker  black Non-smoker
## 4           10     7     7 Non-smoker  black Non-smoker
## 5           21    16    16 Non-smoker  black Non-smoker
## 6            5     1     2 Non-smoker  black Non-smoker
```


```r
clean_df %>% 
  filter(sex == "female" | educ == 20) %>% 
  head()
```

```
##   v1 id educ age    sex   race married income_1 income_2 depression_1
## 1  1  1   14  58 female  other       0    42504    56418           23
## 2  4  4   14  35 female  other       1    41654    56264           14
## 3  8  8   21  66 female  white       1    62362    83720            6
## 4  9  9   21  38 female  other       0    62716    84363           20
## 5 10 10   20  53 female  white       1    60309    80255           11
## 6 15 15   22  57 female latinx       1    66286    87292           10
##   depression_2 anx_1 anx_2    smoking race_f  smoking_f
## 1           26    21    22 Non-smoker  other Non-smoker
## 2           19    15    10         99  other         99
## 3            5     5     4 Non-smoker  white Non-smoker
## 4           26    17    19 Non-smoker  other Non-smoker
## 5           13    11    10     Smoker  white     Smoker
## 6           12    12    12 Non-smoker latinx Non-smoker
```

Can also have it match multiple things


```r
clean_df %>% 
  filter(race %in% c("black", "latinx")) %>% 
  head()
```

```
##   v1 id educ age  sex   race married income_1 income_2 depression_1
## 1  2  2   15  32 male  black       0    45341    59810           20
## 2  7  7   23  46 male latinx       1    68791    91662           13
## 3 11 11   13  19 male latinx       0    38609    51231           24
## 4 12 12   12  52 male latinx       0    35765    48350           21
## 5 13 13   22  24 male latinx       0    65359    88375           12
## 6 14 14   12  69 male latinx       1    35638    47970           10
##   depression_2 anx_1 anx_2    smoking race_f  smoking_f
## 1           25    20    23     Smoker  black     Smoker
## 2           17    16    17 Non-smoker latinx Non-smoker
## 3           28    26    25       <NA> latinx       <NA>
## 4           24    23    22 Non-smoker latinx Non-smoker
## 5           14    12     9 Non-smoker latinx Non-smoker
## 6           12    10    12 Non-smoker latinx Non-smoker
```


### Mutate

Anytime you see mutate() it means you are adding a new variable or modifying an existing one.  For example, lets take a look at what class our sex variable is.



```r
class(clean_df$sex)
```

```
## [1] "character"
```

When we imported the data, R did not know sex was a factor. So, we need to change it to be factor. Using the mutate function allows us to modify existing variables, or create new variables. In this case, I make a new variable called "sex_f" and change sex to be a factor. 


```r
clean_df <- clean_df %>% 
  mutate(sex_f = factor(sex))
class(clean_df$sex_f)
```

```
## [1] "factor"
```

There are loads of useful functions for mutating a variable! We will present a few here.

#### Case_when

When you want to modify variables based on various possible conditions, you can use the case_when() function. For example, when a categorical variable is dummy-coded to be 0,1,2.. you can change it to have actual name labels. In this example, our married variable i supposed to be factor of 0 = not married and 1 = married. Lets look at our married variable before we use mutate and case_when.


```r
summary(clean_df$married)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    0.00    0.00    0.00    0.43    1.00    1.00
```

The next code chunk will show a new variable, called "married_f" that has levels "married" and "not married" and is a factor. To do this, we need to use mutate to create the new married_f variable, and then tell r that when the married variable = 1, then label married, and if married = 0, label it not married. Note that we need to use == to specify that it is equal to something. We also need to put our labels in "" when they are words. The last line of code turns married_f into a factor, rather than a character variable. 



```r
clean_df <- clean_df %>% 
  mutate(married_f = case_when(
    married == 1 ~ "married",
    married == 0 ~ "not married"
  ) %>% as.factor())

glimpse(clean_df)
```

```
## Rows: 100
## Columns: 18
## $ v1           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17…
## $ id           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17…
## $ educ         <int> 14, 15, 23, 14, 22, 15, 23, 21, 21, 20, 13, 12, 22, 12, 2…
## $ age          <int> 58, 32, 47, 35, 51, 73, 46, 66, 38, 53, 19, 52, 24, 69, 5…
## $ sex          <chr> "female", "male", "male", "female", "male", "male", "male…
## $ race         <chr> "other", "black", "other", "other", "white", "white", "la…
## $ married      <int> 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, …
## $ income_1     <int> 42504, 45341, 69261, 41654, 66149, 46009, 68791, 62362, 6…
## $ income_2     <int> 56418, 59810, 92139, 56264, 88635, 59918, 91662, 83720, 8…
## $ depression_1 <int> 23, 20, 16, 14, 10, 14, 13, 6, 20, 11, 24, 21, 12, 10, 10…
## $ depression_2 <int> 26, 25, 20, 19, 13, 17, 17, 5, 26, 13, 28, 24, 14, 12, 12…
## $ anx_1        <int> 21, 20, 15, 15, 8, 14, 16, 5, 17, 11, 26, 23, 12, 10, 12,…
## $ anx_2        <int> 22, 23, 19, 10, 7, 16, 17, 4, 19, 10, 25, 22, 9, 12, 12, …
## $ smoking      <chr> "Non-smoker", "Smoker", "Smoker", "99", "Non-smoker", "No…
## $ race_f       <fct> other, black, other, other, white, white, latinx, white, …
## $ smoking_f    <fct> Non-smoker, Smoker, Smoker, 99, Non-smoker, Non-smoker, N…
## $ sex_f        <fct> female, male, male, female, male, male, male, female, fem…
## $ married_f    <fct> not married, not married, not married, married, not marri…
```

Here is another example.


```r
clean_df <- clean_df %>% 
  mutate(income_cat = case_when(
    income_1 > mean(income_1, na.rm=TRUE) + sd(income_1, na.rm=TRUE) ~ "High Earner",
    income_1 > mean(income_1, na.rm=TRUE) ~ "Mid-High Earner",
    income_1 <= mean(income_1, na.rm=TRUE) - sd(income_1, na.rm=TRUE) ~ "Low Earner",
    income_1 <= mean(income_1, na.rm=TRUE) ~ "Mid-Low Earner",
  ) %>% as.factor())

glimpse(clean_df)
```

```
## Rows: 100
## Columns: 19
## $ v1           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17…
## $ id           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17…
## $ educ         <int> 14, 15, 23, 14, 22, 15, 23, 21, 21, 20, 13, 12, 22, 12, 2…
## $ age          <int> 58, 32, 47, 35, 51, 73, 46, 66, 38, 53, 19, 52, 24, 69, 5…
## $ sex          <chr> "female", "male", "male", "female", "male", "male", "male…
## $ race         <chr> "other", "black", "other", "other", "white", "white", "la…
## $ married      <int> 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, …
## $ income_1     <int> 42504, 45341, 69261, 41654, 66149, 46009, 68791, 62362, 6…
## $ income_2     <int> 56418, 59810, 92139, 56264, 88635, 59918, 91662, 83720, 8…
## $ depression_1 <int> 23, 20, 16, 14, 10, 14, 13, 6, 20, 11, 24, 21, 12, 10, 10…
## $ depression_2 <int> 26, 25, 20, 19, 13, 17, 17, 5, 26, 13, 28, 24, 14, 12, 12…
## $ anx_1        <int> 21, 20, 15, 15, 8, 14, 16, 5, 17, 11, 26, 23, 12, 10, 12,…
## $ anx_2        <int> 22, 23, 19, 10, 7, 16, 17, 4, 19, 10, 25, 22, 9, 12, 12, …
## $ smoking      <chr> "Non-smoker", "Smoker", "Smoker", "99", "Non-smoker", "No…
## $ race_f       <fct> other, black, other, other, white, white, latinx, white, …
## $ smoking_f    <fct> Non-smoker, Smoker, Smoker, 99, Non-smoker, Non-smoker, N…
## $ sex_f        <fct> female, male, male, female, male, male, male, female, fem…
## $ married_f    <fct> not married, not married, not married, married, not marri…
## $ income_cat   <fct> Mid-Low Earner, Mid-Low Earner, Mid-High Earner, Low Earn…
```

This last one is a complex example but it shows the utility of `case_when()`. Any guesses what this is doing?


```r
data %>% 
  rowwise() %>% 
  mutate(
    var1 = 
      case_when(
        sum(
          item1 > 2,
          item2 > 2,
          item3 > 2,
          item4 > 2,
          item5 > 2,
          na.rm=TRUE
        ) >= 6 &
        sum(
          perf1 > 3,
          perf2 > 3,
          perf3 > 3,
          na.rm=TRUE
        ) > 0 ~ 1,
        TRUE ~ 0
      )
  ) %>% 
  ungroup() %>% 
  mutate(var1 = factor(var1))
```


#### Rowsums and Rowmeans


```r
clean_df <- clean_df %>% 
  mutate(dep_v1 = furniture::rowmeans(depression_1, depression_2))

clean_df <- clean_df %>% 
  rowwise() %>% 
  mutate(dep_v2 = mean(c(depression_1, depression_2))) %>% 
  ungroup()

glimpse(clean_df)
```

```
## Rows: 100
## Columns: 21
## $ v1           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17…
## $ id           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17…
## $ educ         <int> 14, 15, 23, 14, 22, 15, 23, 21, 21, 20, 13, 12, 22, 12, 2…
## $ age          <int> 58, 32, 47, 35, 51, 73, 46, 66, 38, 53, 19, 52, 24, 69, 5…
## $ sex          <chr> "female", "male", "male", "female", "male", "male", "male…
## $ race         <chr> "other", "black", "other", "other", "white", "white", "la…
## $ married      <int> 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, …
## $ income_1     <int> 42504, 45341, 69261, 41654, 66149, 46009, 68791, 62362, 6…
## $ income_2     <int> 56418, 59810, 92139, 56264, 88635, 59918, 91662, 83720, 8…
## $ depression_1 <int> 23, 20, 16, 14, 10, 14, 13, 6, 20, 11, 24, 21, 12, 10, 10…
## $ depression_2 <int> 26, 25, 20, 19, 13, 17, 17, 5, 26, 13, 28, 24, 14, 12, 12…
## $ anx_1        <int> 21, 20, 15, 15, 8, 14, 16, 5, 17, 11, 26, 23, 12, 10, 12,…
## $ anx_2        <int> 22, 23, 19, 10, 7, 16, 17, 4, 19, 10, 25, 22, 9, 12, 12, …
## $ smoking      <chr> "Non-smoker", "Smoker", "Smoker", "99", "Non-smoker", "No…
## $ race_f       <fct> other, black, other, other, white, white, latinx, white, …
## $ smoking_f    <fct> Non-smoker, Smoker, Smoker, 99, Non-smoker, Non-smoker, N…
## $ sex_f        <fct> female, male, male, female, male, male, male, female, fem…
## $ married_f    <fct> not married, not married, not married, married, not marri…
## $ income_cat   <fct> Mid-Low Earner, Mid-Low Earner, Mid-High Earner, Low Earn…
## $ dep_v1       <dbl> 24.5, 22.5, 18.0, 16.5, 11.5, 15.5, 15.0, 5.5, 23.0, 12.0…
## $ dep_v2       <dbl> 24.5, 22.5, 18.0, 16.5, 11.5, 15.5, 15.0, 5.5, 23.0, 12.0…
```

### Forcats Package


```r
library(forcats) # forcats is also in tidyverse so if you downloaded tidyverse you don't need to download this as well
```

#### Relevel

You can manually reorder factor levels


```r
clean_df %>% 
  mutate(race_f = fct_relevel(race_f, "white", "black", "latinx", "other"))
```

```
## # A tibble: 100 × 21
##       v1    id  educ   age sex    race   married income_1 income_2 depression_1
##    <int> <int> <int> <int> <chr>  <chr>    <int>    <int>    <int>        <int>
##  1     1     1    14    58 female other        0    42504    56418           23
##  2     2     2    15    32 male   black        0    45341    59810           20
##  3     3     3    23    47 male   other        0    69261    92139           16
##  4     4     4    14    35 female other        1    41654    56264           14
##  5     5     5    22    51 male   white        0    66149    88635           10
##  6     6     6    15    73 male   white        1    46009    59918           14
##  7     7     7    23    46 male   latinx       1    68791    91662           13
##  8     8     8    21    66 female white        1    62362    83720            6
##  9     9     9    21    38 female other        0    62716    84363           20
## 10    10    10    20    53 female white        1    60309    80255           11
## # … with 90 more rows, and 11 more variables: depression_2 <int>, anx_1 <int>,
## #   anx_2 <int>, smoking <chr>, race_f <fct>, smoking_f <fct>, sex_f <fct>,
## #   married_f <fct>, income_cat <fct>, dep_v1 <dbl>, dep_v2 <dbl>
```

#### Reorder

Reorder a factor by its levels' frequency


```r
clean_df %>% 
  mutate(race_f = fct_infreq(race_f))
```

```
## # A tibble: 100 × 21
##       v1    id  educ   age sex    race   married income_1 income_2 depression_1
##    <int> <int> <int> <int> <chr>  <chr>    <int>    <int>    <int>        <int>
##  1     1     1    14    58 female other        0    42504    56418           23
##  2     2     2    15    32 male   black        0    45341    59810           20
##  3     3     3    23    47 male   other        0    69261    92139           16
##  4     4     4    14    35 female other        1    41654    56264           14
##  5     5     5    22    51 male   white        0    66149    88635           10
##  6     6     6    15    73 male   white        1    46009    59918           14
##  7     7     7    23    46 male   latinx       1    68791    91662           13
##  8     8     8    21    66 female white        1    62362    83720            6
##  9     9     9    21    38 female other        0    62716    84363           20
## 10    10    10    20    53 female white        1    60309    80255           11
## # … with 90 more rows, and 11 more variables: depression_2 <int>, anx_1 <int>,
## #   anx_2 <int>, smoking <chr>, race_f <fct>, smoking_f <fct>, sex_f <fct>,
## #   married_f <fct>, income_cat <fct>, dep_v1 <dbl>, dep_v2 <dbl>
```

Reorder a factor by a numeric variable


```r
clean_df %>% 
  mutate(race_f = fct_reorder(race_f, income_1))
```

```
## # A tibble: 100 × 21
##       v1    id  educ   age sex    race   married income_1 income_2 depression_1
##    <int> <int> <int> <int> <chr>  <chr>    <int>    <int>    <int>        <int>
##  1     1     1    14    58 female other        0    42504    56418           23
##  2     2     2    15    32 male   black        0    45341    59810           20
##  3     3     3    23    47 male   other        0    69261    92139           16
##  4     4     4    14    35 female other        1    41654    56264           14
##  5     5     5    22    51 male   white        0    66149    88635           10
##  6     6     6    15    73 male   white        1    46009    59918           14
##  7     7     7    23    46 male   latinx       1    68791    91662           13
##  8     8     8    21    66 female white        1    62362    83720            6
##  9     9     9    21    38 female other        0    62716    84363           20
## 10    10    10    20    53 female white        1    60309    80255           11
## # … with 90 more rows, and 11 more variables: depression_2 <int>, anx_1 <int>,
## #   anx_2 <int>, smoking <chr>, race_f <fct>, smoking_f <fct>, sex_f <fct>,
## #   married_f <fct>, income_cat <fct>, dep_v1 <dbl>, dep_v2 <dbl>
```

#### Lump

When you have a factor with too many levels, you can lump all of the infrequent ones into one factor, "other". You can specify how many levels you want to include. the argument "n" is the number of levels you want to keep, besides the "other" category that will be made from the lump function. You can also include the argument other_level = "" if you would like to change the name from other to something more specific.


```r
clean_df %>% 
  mutate(race_f = fct_lump(race_f, n = 2))
```

```
## # A tibble: 100 × 21
##       v1    id  educ   age sex    race   married income_1 income_2 depression_1
##    <int> <int> <int> <int> <chr>  <chr>    <int>    <int>    <int>        <int>
##  1     1     1    14    58 female other        0    42504    56418           23
##  2     2     2    15    32 male   black        0    45341    59810           20
##  3     3     3    23    47 male   other        0    69261    92139           16
##  4     4     4    14    35 female other        1    41654    56264           14
##  5     5     5    22    51 male   white        0    66149    88635           10
##  6     6     6    15    73 male   white        1    46009    59918           14
##  7     7     7    23    46 male   latinx       1    68791    91662           13
##  8     8     8    21    66 female white        1    62362    83720            6
##  9     9     9    21    38 female other        0    62716    84363           20
## 10    10    10    20    53 female white        1    60309    80255           11
## # … with 90 more rows, and 11 more variables: depression_2 <int>, anx_1 <int>,
## #   anx_2 <int>, smoking <chr>, race_f <fct>, smoking_f <fct>, sex_f <fct>,
## #   married_f <fct>, income_cat <fct>, dep_v1 <dbl>, dep_v2 <dbl>
```

In this example, we previously had four levels of the race variable: white, black, latinx, and other. When we specified n = 2, we lumped the other and black categories (the most infrequent two) into one "Other" category. It kept our two most frequent categories: white and latinx. 


#### Other Useful Functions for Factors

![Forcats cheat sheet](/Users/dculi/Box/R Course/forcatscheat.png)


### Group_by

The group_by() function allows for us to group our data by a specific variable and compare groups with descriptive statistics. 


```r
clean_df %>% 
  group_by(race_f) %>% 
  summarize(N = n(), 
            mean = mean(depression_1),
            sd = sd(depression_1))
```

```
## # A tibble: 4 × 4
##   race_f     N  mean    sd
##   <fct>  <int> <dbl> <dbl>
## 1 black     20  12.9  6.93
## 2 latinx    33  13.5  5.75
## 3 other     14  15.4  6.10
## 4 white     33  13.6  6.09
```

This example groups the dataset by race_f and summarizes it by the number per race (the n() argument), and provides the mean (mean()) and standard deviation (sd()) for depression scores by race. 


