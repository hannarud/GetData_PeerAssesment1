
require(data.table)
require(dplyr)
require(reshape2)

# Read the data set

data.directory <- "data/"
if (!dir.exists(data.directory)) {
    dir.create(data.directory)
}

data.archive <- "getdata_projectfiles_UCI HAR Dataset.zip"
data.archive.path <- paste0(data.directory, data.archive)
if (!file.exists(data.archive.path)){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  destfile=data.archive.path, method="curl")
}

data.unzipped <- "UCI HAR Dataset"
data.unzipped.path <- paste0(data.directory, data.unzipped)
if (!dir.exists(data.unzipped.path)) {
    unzip(data.archive.path, files = NULL, list = FALSE,
          overwrite = FALSE, exdir = data.directory)
}

# OK, data is ready in the proper folder

# Merge the data set
# Actually merging here is just concatencating train and test data sets

# Person numbers are written under subject_XXX.txt
person.number.train <- read.table(file = "./data/UCI HAR Dataset/train/subject_train.txt")
person.number.test <- read.table(file = "./data/UCI HAR Dataset/test/subject_test.txt")
person.number <- rbind(person.number.train, person.number.test)
colnames(person.number) <- c("PERSON_NUMBER")

remove(person.number.train, person.number.test)
head(person.number)

# Activity numbers are written under y_XXX.txt
activity.number.train <- read.table(file = "./data/UCI HAR Dataset/train/y_train.txt")
activity.number.test <- read.table(file = "./data/UCI HAR Dataset/test/y_test.txt")
activity.number <- rbind(activity.number.train, activity.number.test)
colnames(activity.number) <- c("ACTIVITY_NUMBER")

remove(activity.number.train, activity.number.test)

# We have activities as numbers - need to have them as description

# First let's have a table with activity labels
activity.labels <- read.table(file = "./data/UCI HAR Dataset/activity_labels.txt")

# So we will match the activity number with activity name
activity.name <- sapply(activity.number, function (x) { factor(x,
                                                               levels = activity.labels[,1],
                                                               labels = activity.labels[,2]) })
colnames(activity.name) <- c("ACTIVITY_NAME")

remove(activity.labels, activity.number)
head(activity.name)

# Next we need to extract the features names
features.names <- read.table("data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[, 2]

# Measures are written under X_XXX.txt
measures.train <- read.table(file = "./data/UCI HAR Dataset/train/X_train.txt")
measures.test <- read.table(file = "./data/UCI HAR Dataset/test/X_test.txt")
measures <- rbind(measures.train, measures.test)
colnames(measures) <- features.names

remove(measures.train, measures.test)

# Finally we can merge our data into one tidy data.table
tidy.measures <- data.table(person.number,
                            activity.name,
                            measures)

head(tidy.measures)
colnames(tidy.measures)

# OK, the next step is to extract only the measurements on the mean and standard deviation for each measurement
tidy.mean.sd <- select(tidy.measures,
                       PERSON_NUMBER,
                       ACTIVITY_NAME,
                       grep("mean", colnames(tidy.measures)),
                       grep("std", colnames(tidy.measures)))

# And finally create tidy data set with the average of each variable for each activity and each subject
melted.tidy <- melt(data = tidy.mean.sd, id.vars = c("PERSON_NUMBER", "ACTIVITY_NAME"))
tidy.final <- dcast(melted.tidy, PERSON_NUMBER + ACTIVITY_NAME ~ variable, mean)

write.table(x = tidy.final, file = "data/tidy_data.txt", row.names = FALSE)