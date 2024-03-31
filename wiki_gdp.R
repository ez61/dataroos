# Load the rvest package
library(rvest)

# Set the Wikipedia page URL
url <- "https://en.wikipedia.org/wiki/List_of_countries_by_average_wage"

# Read the HTML content of the page
page <- read_html(url)

# Extract tables from the HTML content
tables <- html_table(page)

# Access the desired table (assuming the first one is what we need)
my_table <- tables[[1]]

write.csv(my_table, "GDP for Excel.csv", row.names = FALSE)




# You can now inspect, clean, and use 'my_table' as needed
print(head(my_table))


my_table$Country <- gsub("\\*", "", my_table$Country)

my_table$Country <- gsub(" ", "", my_table$Country)
#my_table$Country <- trimws(my_table$Country, which = "right")

my_table$`2000` <- as.numeric(gsub(",", "", my_table$`2000`))
my_table$`2010` <- as.numeric(gsub(",", "", my_table$`2010`))
my_table$`2020` <- as.numeric(gsub(",", "", my_table$`2020`))
my_table$`2022` <- as.numeric(gsub(",", "", my_table$`2022`))

str(my_table)

colnames(my_table)
colnames(my_table) <- c("Country", "Yr2000", "Yr2010", "Yr2020", "Yr2022")



exceldata <- read.csv("GDP for Excel.csv", header = TRUE)
head(exceldata)
str(exceldata)




