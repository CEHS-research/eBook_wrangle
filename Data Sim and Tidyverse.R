library(tidyverse)



                            # Make Dataset
set.seed(843)
data <- tibble(ID = 1:100,
               Educ = sample(10:25, 100, replace = T),
               Age = sample(18:75, 100, replace = T),
               Sex = sample(c("male", "female"), 100, replace = T),
               Race = sample(c("white", "white", "white", "white", 
                               "black", "black", "latinx", "latinx", "other"), 
                             100, replace = T),
               Married = sample(0:1, 100, replace = T),
               Income_1 = round(3000*Educ + rnorm(100, sd = 500)),
               INCOME_2 = round(4000 *Educ + rnorm(100, sd = 500)),
               Depression_1 = sample(4:25, 100, replace = T),
               Depression_2 = round(1.2*Depression_1 + rnorm(100, sd = 1)),
               Anx_1 = round(Depression_1 + rnorm(100, sd = 2)),
               Anx_2 = round(Anx_1 + rnorm(100, sd = 2)))

data <- data %>% 
  dplyr::group_by(Sex) %>% 
  dplyr::mutate(smoking = dplyr::case_when(Sex == "female" ~ sample(c("Smoker", "Non-smoker", 99, NA), 
                                                                                size = n(),
                                                                                replace = TRUE,
                                                                                prob = c(0.15, 0.65, 0.10, 0.10)),
                                                Sex == "male"   ~ sample(c("Smoker", "Non-smoker", 99, NA), 
                                                                                size = n(), 
                                                                                replace = TRUE,
                                                                                prob = c(0.25, 0.65, 0.10, 0.10)))) 
  dplyr::ungroup()

write.csv(data, "C:\\Users\\dculi\\Box\\R Course\\data_csv.csv")

library(haven)
write_sav(data, "C:\\Users\\dculi\\Box\\R Course\\data_sav.sav")
  
#install.packages("tidyverse")
library(tidyverse)

#Piping

summary(data)

data %>% 
  summary()

#Piping with Select function

data[, c("id", "educ", "age")]

data[, c(1:3)]

data %>% 
  select(id, educ, age)

data %>% 
  select(1:3)

data %>% 
  select(starts_with("income"))

data %>% 
  select(ends_with(c("_1", "_2")))

data %>% 
  select(contains("anx"))


#Piping with Mutate

class(data$sex)

data <- data %>% 
  mutate(sexF = factor(sex))

class(data$sexF)

# Group and Summarize

data$race <- as.factor(data$race)

data %>% 
  group_by(race) %>% 
  summarize(N = n(), 
            m = mean(depression_1),
            sd = sd(depression_1))
  
# Filter

data[data$anx_1 > 20,]

data %>% 
  filter(anx_1 > 20)

data %>% 
  filter(sexF == "female")

data %>% 
  filter(sexF == "female" & race == "black")

data %>% 
  filter(sexF == "female" | educ == 20)


