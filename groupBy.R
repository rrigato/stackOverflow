########################################################
#Stack Overflow question:
#http://stackoverflow.com/questions/40700126/manipulation-of-data-in-r-using-data-table-or-dplyr-with-groupby-and-subsetting
#
#
#
#########################################################

#initialize the output frame
outputFrame = as.data.frame(matrix(nrow = length(unique(train$Name)),
ncol = 4))

#renaming the data frame
names(outputFrame) = c("Names", "daysBetween", "avgX", "avgY")

#turn the date to a date
train$Date = as.Date(train$Date, "%m/%d/%Y")

#initialize the outputCounter
outputCounter = 1


#iterates over every unique Name in the data frame
for(name in as.character(unique(train$Name)))
{
	#subsets the dataframe into the values of each given 
	#level of Name
	dfSubset = train[which(train$Name == name),]

	#Orders the dataframe by date
	dfSubset = dfSubset[order(dfSubset$Date),]
	
	#get the 3 most recent dates
	dfSubset = dfSubset[(nrow(dfSubset) -2):nrow(dfSubset),]

	#fill the names
	outputFrame$Names[outputCounter] = name

	#fill the days between
	outputFrame$daysBetween[outputCounter] = as.numeric(max(dfSubset$Date) - min(dfSubset$Date))

	#get the average X
	outputFrame$avgX[outputCounter] = mean(dfSubset$X)

	#get the average Y
	outputFrame$avgY[outputCounter] = mean(dfSubset$Y)

	
	#increment outputCounter
	outputCounter = outputCounter +1
}
